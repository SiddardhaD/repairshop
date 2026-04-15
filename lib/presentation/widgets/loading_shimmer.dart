import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';

class LoadingShimmer extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;

  const LoadingShimmer({
    super.key,
    required this.height,
    this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBase,
      highlightColor: isDark ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlight,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class RepairCardShimmer extends StatelessWidget {
  const RepairCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const LoadingShimmer(height: 48, width: 48, borderRadius: 12),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingShimmer(
                        height: 16,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      const SizedBox(height: 8),
                      LoadingShimmer(
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                ),
                const LoadingShimmer(height: 24, width: 80, borderRadius: 12),
              ],
            ),
            const SizedBox(height: 16),
            LoadingShimmer(
              height: 8,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            const SizedBox(height: 16),
            LoadingShimmer(
              height: 12,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
