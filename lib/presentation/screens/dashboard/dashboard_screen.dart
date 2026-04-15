import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:repairtracker/domain/entities/vendor.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/responsive.dart';
import '../../../domain/entities/repair.dart';
import '../../providers/auth_provider.dart';
import '../../providers/repair_provider.dart';
import '../../providers/vendor_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/error_view.dart';
import '../../../data/services/mock_data_service.dart';
import '../../../domain/entities/promotion.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final repairsAsync = ref.watch(userRepairsProvider);
    final stats = ref.watch(repairStatsProvider);
    final featuredVendorsAsync = ref.watch(featuredVendorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(RouteNames.notifications),
          ),
          IconButton(
            icon: Icon(
              ref.watch(themeNotifierProvider) == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () =>
                ref.read(themeNotifierProvider.notifier).toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(RouteNames.profile),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userRepairsProvider);
          ref.invalidate(featuredVendorsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: [
            _buildHeader(context, currentUser),
            Spacing.gapXS,
            _buildStatsSection(context, stats),
            Spacing.gapXS,
            _buildPromotionSection(context),
            Spacing.gapXS,
            _buildActiveRepairsSection(context, ref, repairsAsync),
            Spacing.gapXS,
            _buildFeaturedVendorsSection(context, ref, featuredVendorsAsync),
            const SizedBox(height: 32),
            _buildSwiggyStyleSection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () => context.push(RouteNames.addRepair),
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add_circle_outline, size: 24),
          label: const Text(
            'Add Repair',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AsyncValue<dynamic> currentUser) {
    return Container(
      padding: Spacing.paddingMD,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: const Icon(
              Icons.person,
              size: 32,
              color: AppColors.primaryBlue,
            ),
          ),
          Spacing.gapMD,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${currentUser.value?.name ?? "User"} 👋',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Track your repair items',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, Map<String, int> stats) {
    return Padding(
      padding: Spacing.horizontalXS,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Spacing.horizontalMD,
            child: Text(
              'Overview',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Spacing.gapXS,
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 0,
            crossAxisSpacing: 1,
            childAspectRatio: 1.4,
            children: [
              StatCard(
                title: 'Active Repairs',
                value: stats['active'].toString(),
                icon: Icons.pending_actions,
                color: AppColors.info,
              ),
              StatCard(
                title: 'In Progress',
                value: stats['inProgress'].toString(),
                icon: Icons.build,
                color: AppColors.warning,
              ),
              StatCard(
                title: 'Completed',
                value: stats['completed'].toString(),
                icon: Icons.check_circle,
                color: AppColors.success,
              ),
              StatCard(
                title: 'Out for Delivery',
                value: stats['outForDelivery'].toString(),
                icon: Icons.local_shipping,
                color: AppColors.accentPurple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionSection(BuildContext context) {
    final promotions = MockDataService().getMockPromotions();
    // Map of promo images to cycle through
    final promoImages = [
      'assets/images/promo_mobile.png',
      'assets/images/promo_ac.png',
      'assets/images/promo_home.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Spacing.horizontalMD,
          child: Text(
            'Special Offers',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Spacing.gapXS,
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: Spacing.horizontalXS,
            itemCount: promotions.length,
            itemBuilder: (context, index) {
              final promotion = promotions[index];
              final imageAsset = promoImages[index % promoImages.length];
              return _buildPromotionCard(context, promotion, imageAsset);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionCard(
    BuildContext context,
    Promotion promotion,
    String imageAsset,
  ) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        promotion.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        promotion.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (promotion.discountPercentage != null)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${promotion.discountPercentage}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveRepairsSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Repair>> repairsAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Spacing.horizontalMD,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Repairs',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
        ),
        repairsAsync.when(
          data: (repairs) {
            final activeRepairs = repairs
                .where(
                  (r) =>
                      r.status != RepairStatus.delivered &&
                      r.status != RepairStatus.completed,
                )
                .take(5)
                .toList();

            if (activeRepairs.isEmpty) {
              return const EmptyState(
                icon: Icons.inventory_2_outlined,
                title: 'No Active Repairs',
                message: 'You don\'t have any active repairs at the moment.',
                actionText: 'Add Repair',
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activeRepairs.length,
              itemBuilder: (context, index) {
                return _buildRepairCard(context, activeRepairs[index]);
              },
            );
          },
          loading: () => Column(
            children: List.generate(3, (_) => const RepairCardShimmer()),
          ),
          error: (error, stack) => ErrorView(
            message: error.toString(),
            onRetry: () => ref.invalidate(userRepairsProvider),
          ),
        ),
      ],
    );
  }

  Widget _buildRepairCard(BuildContext context, Repair repair) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () => context.push('${RouteNames.repairDetails}/${repair.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getProductIcon(repair.productName),
                      color: AppColors.primaryBlue,
                      size: 24,
                    ),
                  ),
                  Spacing.gapMD,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repair.productName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          repair.vendorName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(repair.status),
                ],
              ),
              Spacing.gapMD,
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: repair.status.progress,
                  minHeight: 8,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                      ? AppColors.dividerLight
                      : AppColors.dividerDark,
                ),
              ),
              Spacing.gapMD,
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Expected: ${repair.expectedDeliveryDate.toFormattedDate()}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Icon(Icons.phone, size: 14, color: AppColors.primaryBlue),
                  const SizedBox(width: 4),
                  Text(
                    'Call Vendor',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(RepairStatus status) {
    Color color;
    switch (status) {
      case RepairStatus.received:
        color = AppColors.info;
        break;
      case RepairStatus.diagnosing:
        color = AppColors.warning;
        break;
      case RepairStatus.waitingForParts:
        color = AppColors.accentOrange;
        break;
      case RepairStatus.repairing:
        color = AppColors.primaryBlue;
        break;
      case RepairStatus.completed:
        color = AppColors.success;
        break;
      case RepairStatus.outForDelivery:
        color = AppColors.accentPurple;
        break;
      case RepairStatus.delivered:
        color = AppColors.success;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  IconData _getProductIcon(String productName) {
    final name = productName.toLowerCase();
    if (name.contains('mobile') || name.contains('phone')) {
      return Icons.phone_android;
    } else if (name.contains('laptop') || name.contains('computer')) {
      return Icons.laptop;
    } else if (name.contains('tv') || name.contains('television')) {
      return Icons.tv;
    } else if (name.contains('ac') || name.contains('air')) {
      return Icons.ac_unit;
    } else if (name.contains('induction') || name.contains('stove')) {
      return Icons.soup_kitchen;
    } else if (name.contains('fridge') || name.contains('refrigerator')) {
      return Icons.kitchen;
    } else if (name.contains('watch')) {
      return Icons.watch;
    }
    return Icons.build;
  }

  Widget _buildFeaturedVendorsSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Vendor>> featuredVendorsAsync,
  ) {
    // Vendor service images
    final vendorImages = [
      'assets/images/vendor_1.png',
      'assets/images/vendor_2.png',
      'assets/images/vendor_3.png',
      'assets/images/vendor_4.png',
      'assets/images/vendor_5.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Spacing.horizontalMD,
          child: Text(
            'Featured Vendors',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Spacing.gapXS,
        featuredVendorsAsync.when(
          data: (vendors) {
            return SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // padding: Spacing.horizontalXS,
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  final vendor = vendors[index];
                  final vendorImage = vendorImages[index % vendorImages.length];
                  return SizedBox(
                    width: 250,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    vendorImage,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Spacing.gapSM,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        vendor.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 12,
                                            color: AppColors.warning,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${vendor.rating} (${vendor.totalReviews})',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.color,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${vendor.distanceInKm} km away',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text('Book Now'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorView(
            message: error.toString(),
            onRetry: () => ref.invalidate(featuredVendorsProvider),
          ),
        ),
      ],
    );
  }

  Widget _buildSwiggyStyleSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue.withOpacity(0.05),
            AppColors.accentTeal.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.error,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Love your gadgets?',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold, height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We\'ll keep them running like new! ⚡',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildQuickStat(
                  context,
                  '1000+',
                  'Happy Customers',
                  Icons.people_outline,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickStat(
                  context,
                  '24/7',
                  'Support',
                  Icons.support_agent_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickStat(
                  context,
                  '95%',
                  'Success Rate',
                  Icons.verified_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, size: 24, color: AppColors.primaryBlue),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            // color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}
