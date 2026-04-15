import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  factory StatusBadge.received() {
    return const StatusBadge(
      text: 'Received',
      backgroundColor: AppColors.info,
      textColor: Colors.white,
      icon: Icons.check_circle_outline,
    );
  }

  factory StatusBadge.diagnosing() {
    return const StatusBadge(
      text: 'Diagnosing',
      backgroundColor: AppColors.warning,
      textColor: Colors.white,
      icon: Icons.search,
    );
  }

  factory StatusBadge.waitingForParts() {
    return const StatusBadge(
      text: 'Waiting for Parts',
      backgroundColor: AppColors.accentOrange,
      textColor: Colors.white,
      icon: Icons.schedule,
    );
  }

  factory StatusBadge.repairing() {
    return const StatusBadge(
      text: 'Repairing',
      backgroundColor: AppColors.primaryBlue,
      textColor: Colors.white,
      icon: Icons.build,
    );
  }

  factory StatusBadge.completed() {
    return const StatusBadge(
      text: 'Completed',
      backgroundColor: AppColors.success,
      textColor: Colors.white,
      icon: Icons.check_circle,
    );
  }

  factory StatusBadge.outForDelivery() {
    return const StatusBadge(
      text: 'Out for Delivery',
      backgroundColor: AppColors.accentPurple,
      textColor: Colors.white,
      icon: Icons.local_shipping,
    );
  }

  factory StatusBadge.delivered() {
    return const StatusBadge(
      text: 'Delivered',
      backgroundColor: AppColors.success,
      textColor: Colors.white,
      icon: Icons.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: textColor ?? Colors.white,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
