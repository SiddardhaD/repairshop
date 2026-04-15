import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/responsive.dart';
import '../../../domain/entities/repair.dart';
import '../../providers/auth_provider.dart';
import '../../providers/repair_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddRepairScreen extends ConsumerStatefulWidget {
  const AddRepairScreen({super.key});

  @override
  ConsumerState<AddRepairScreen> createState() => _AddRepairScreenState();
}

class _AddRepairScreenState extends ConsumerState<AddRepairScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _issueController = TextEditingController();
  final _vendorNameController = TextEditingController();
  final _notesController = TextEditingController();
  final _estimatedCostController = TextEditingController();

  DateTime _expectedDeliveryDate = DateTime.now().add(const Duration(days: 7));
  bool _isLoading = false;

  @override
  void dispose() {
    _productNameController.dispose();
    _issueController.dispose();
    _vendorNameController.dispose();
    _notesController.dispose();
    _estimatedCostController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) {
        throw Exception('User not found');
      }

      final repair = Repair(
        id: const Uuid().v4(),
        productName: _productNameController.text.trim(),
        issueDescription: _issueController.text.trim(),
        status: RepairStatus.received,
        createdAt: DateTime.now(),
        expectedDeliveryDate: _expectedDeliveryDate,
        vendorId: const Uuid().v4(),
        vendorName: _vendorNameController.text.trim(),
        userId: user.id,
        notes: _notesController.text.trim().isNotEmpty
            ? _notesController.text.trim()
            : null,
        estimatedCost: _estimatedCostController.text.isNotEmpty
            ? double.tryParse(_estimatedCostController.text)
            : null,
      );

      await ref.read(repairNotifierProvider.notifier).createRepair(repair);

      if (!mounted) return;

      showSnackBar(context, 'Repair added successfully!');
      context.go(RouteNames.dashboard);
    } catch (e) {
      if (!mounted) return;
      showSnackBar(
        context,
        e.toString().replaceAll('Exception: ', ''),
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expectedDeliveryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _expectedDeliveryDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Repair'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: Spacing.paddingMD,
          children: [
            Text(
              'Product Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Spacing.gapMD,
            CustomTextField(
              controller: _productNameController,
              label: 'Product Name',
              hint: 'e.g., Induction Stove, Mobile Phone',
              prefixIcon: const Icon(Icons.devices),
              validator: (value) =>
                  AppValidators.validateRequired(value, fieldName: 'Product name'),
            ),
            Spacing.gapMD,
            CustomTextField(
              controller: _issueController,
              label: 'Issue Description',
              hint: 'Describe the problem in detail',
              prefixIcon: const Icon(Icons.description),
              maxLines: 4,
              validator: (value) =>
                  AppValidators.validateRequired(value, fieldName: 'Issue description'),
            ),
            Spacing.gapXL,
            Text(
              'Vendor Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Spacing.gapMD,
            CustomTextField(
              controller: _vendorNameController,
              label: 'Vendor Name',
              hint: 'e.g., Tech Fix Solutions',
              prefixIcon: const Icon(Icons.store),
              validator: (value) =>
                  AppValidators.validateRequired(value, fieldName: 'Vendor name'),
            ),
            Spacing.gapXL,
            Text(
              'Additional Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Spacing.gapMD,
            Card(
              child: InkWell(
                onTap: _selectDate,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                      Spacing.gapMD,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expected Delivery Date',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_expectedDeliveryDate.day}/${_expectedDeliveryDate.month}/${_expectedDeliveryDate.year}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            Spacing.gapMD,
            CustomTextField(
              controller: _estimatedCostController,
              label: 'Estimated Cost (Optional)',
              hint: 'Enter estimated repair cost',
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.currency_rupee),
            ),
            Spacing.gapMD,
            CustomTextField(
              controller: _notesController,
              label: 'Additional Notes (Optional)',
              hint: 'Any special instructions or notes',
              prefixIcon: const Icon(Icons.note),
              maxLines: 3,
            ),
            Spacing.gapXL,
            CustomButton(
              text: 'Add Repair',
              onPressed: _handleSubmit,
              isLoading: _isLoading,
              width: double.infinity,
            ),
            Spacing.gapMD,
          ],
        ),
      ),
    );
  }
}
