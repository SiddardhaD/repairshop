import 'package:equatable/equatable.dart';

enum NotificationType {
  repairStatusUpdate,
  deliveryUpdate,
  paymentReminder,
  promotional,
  general;

  String get displayName {
    switch (this) {
      case NotificationType.repairStatusUpdate:
        return 'Repair Status Update';
      case NotificationType.deliveryUpdate:
        return 'Delivery Update';
      case NotificationType.paymentReminder:
        return 'Payment Reminder';
      case NotificationType.promotional:
        return 'Promotional';
      case NotificationType.general:
        return 'General';
    }
  }
}

class AppNotification extends Equatable {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? repairId;
  final String? imageUrl;
  final String? actionUrl;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.repairId,
    this.imageUrl,
    this.actionUrl,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? timestamp,
    bool? isRead,
    String? repairId,
    String? imageUrl,
    String? actionUrl,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      repairId: repairId ?? this.repairId,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        message,
        type,
        timestamp,
        isRead,
        repairId,
        imageUrl,
        actionUrl,
      ];
}
