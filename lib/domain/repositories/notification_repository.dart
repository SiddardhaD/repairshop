import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getUserNotifications(String userId);
  Future<AppNotification?> getNotificationById(String id);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<void> deleteNotification(String id);
  Future<int> getUnreadCount(String userId);
  Stream<List<AppNotification>> watchNotifications(String userId);
}
