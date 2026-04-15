import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/responsive.dart';
import '../../../domain/entities/repair.dart';
import '../../providers/repair_provider.dart';
import '../../widgets/error_view.dart';

class RepairDetailsScreen extends ConsumerWidget {
  final String repairId;

  const RepairDetailsScreen({super.key, required this.repairId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repairAsync = ref.watch(repairByIdProvider(repairId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repair Details'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: repairAsync.when(
        data: (repair) {
          if (repair == null) {
            return const Center(child: Text('Repair not found'));
          }
          return _buildContent(context, repair);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(repairByIdProvider(repairId)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Repair repair) {
    return SingleChildScrollView(
      padding: Spacing.paddingXS,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductCard(context, repair),
          Spacing.gapLG,
          _buildStatusTimeline(context, repair),
          Spacing.gapLG,
          _buildVendorInfo(context, repair),
          Spacing.gapLG,
          _buildIssueDescription(context, repair),
          if (repair.notes != null) ...[
            Spacing.gapLG,
            _buildNotes(context, repair),
          ],
          if (repair.estimatedCost != null || repair.actualCost != null) ...[
            Spacing.gapLG,
            _buildCostInfo(context, repair),
          ],
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Repair repair) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.build_circle_outlined,
                    color: AppColors.primaryBlue,
                    size: 32,
                  ),
                ),
                Spacing.gapMD,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repair.productName,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Created ${repair.createdAt.toRelativeTime()}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacing.gapMD,
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: repair.status.progress,
                minHeight: 10,
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                    ? AppColors.dividerLight
                    : AppColors.dividerDark,
              ),
            ),
            Spacing.gapSM,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  repair.status.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(repair.status.progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(BuildContext context, Repair repair) {
    final allStatuses = RepairStatus.values.take(7).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Timeline',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacing.gapMD,
            ...allStatuses.asMap().entries.map((entry) {
              final index = entry.key;
              final status = entry.value;
              final isCompleted = status.progress <= repair.status.progress;
              final isCurrent = status == repair.status;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? AppColors.primaryBlue
                              : Theme.of(context).brightness == Brightness.light
                              ? AppColors.dividerLight
                              : AppColors.dividerDark,
                          border: isCurrent
                              ? Border.all(
                                  color: AppColors.primaryBlue,
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.circle,
                          color: isCompleted ? Colors.white : Colors.grey,
                          size: 16,
                        ),
                      ),
                      if (index < allStatuses.length - 1)
                        Container(
                          width: 2,
                          height: 40,
                          color: isCompleted
                              ? AppColors.primaryBlue
                              : Theme.of(context).brightness == Brightness.light
                              ? AppColors.dividerLight
                              : AppColors.dividerDark,
                        ),
                    ],
                  ),
                  Spacing.gapMD,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            status.displayName,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: isCurrent
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isCompleted
                                      ? Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.color
                                      : Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.color,
                                ),
                          ),
                          if (isCurrent) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Current Status',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.primaryBlue),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorInfo(BuildContext context, Repair repair) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vendor Information',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacing.gapMD,
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                  child: Icon(Icons.store, color: AppColors.primaryBlue),
                ),
                Spacing.gapMD,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repair.vendorName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Vendor ID: ${repair.vendorId.substring(0, 8)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacing.gapMD,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone, size: 18),
                    label: const Text('Call'),
                  ),
                ),
                Spacing.gapMD,
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.message, size: 18),
                    label: const Text('Message'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueDescription(BuildContext context, Repair repair) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Issue Description',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacing.gapSM,
            Text(
              repair.issueDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Spacing.gapMD,
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 8),
                Text(
                  'Expected Delivery: ${repair.expectedDeliveryDate.toFormattedDate()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotes(BuildContext context, Repair repair) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.note_outlined, color: AppColors.warning),
                Spacing.gapSM,
                Text(
                  'Additional Notes',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacing.gapSM,
            Text(repair.notes!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildCostInfo(BuildContext context, Repair repair) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cost Information',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacing.gapMD,
            if (repair.estimatedCost != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimated Cost:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    repair.estimatedCost!.toCurrency(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
            if (repair.actualCost != null) ...[
              Spacing.gapSM,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Actual Cost:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    repair.actualCost!.toCurrency(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
