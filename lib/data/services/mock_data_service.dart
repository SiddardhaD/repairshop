import 'package:uuid/uuid.dart';
import '../../domain/entities/vendor.dart';
import '../../domain/entities/promotion.dart';
import '../../domain/entities/notification.dart';

class MockDataService {
  final _uuid = const Uuid();

  List<Vendor> getMockVendors() {
    return [
      Vendor(
        id: _uuid.v4(),
        name: 'Tech Fix Solutions',
        phone: '9876543210',
        email: 'contact@techfix.com',
        address: '123 Main Street, City Center',
        rating: 4.8,
        totalReviews: 245,
        specialties: ['Mobile', 'Laptop', 'Tablet'],
        distanceInKm: 2.5,
        description: 'Expert in mobile and laptop repairs with 10+ years of experience.',
      ),
      Vendor(
        id: _uuid.v4(),
        name: 'Home Appliance Care',
        phone: '9876543211',
        email: 'info@homecare.com',
        address: '456 Park Avenue, Downtown',
        rating: 4.6,
        totalReviews: 189,
        specialties: ['AC', 'Refrigerator', 'Washing Machine', 'Induction'],
        distanceInKm: 3.2,
        description: 'Specialized in home appliance repairs and maintenance.',
      ),
      Vendor(
        id: _uuid.v4(),
        name: 'Quick Repair Hub',
        phone: '9876543212',
        email: 'support@quickrepair.com',
        address: '789 Service Road, Tech Park',
        rating: 4.9,
        totalReviews: 312,
        specialties: ['Mobile', 'TV', 'AC', 'Laptop'],
        distanceInKm: 1.8,
        description: 'Fast and reliable repair services for all electronics.',
      ),
      Vendor(
        id: _uuid.v4(),
        name: 'Elite Electronics',
        phone: '9876543213',
        email: 'hello@eliteelectronics.com',
        address: '321 Electronics Street, Mall Road',
        rating: 4.7,
        totalReviews: 198,
        specialties: ['TV', 'Home Theater', 'Camera'],
        distanceInKm: 4.5,
        description: 'Premium electronics repair and servicing center.',
      ),
      Vendor(
        id: _uuid.v4(),
        name: 'Smart Device Clinic',
        phone: '9876543214',
        email: 'clinic@smartdevice.com',
        address: '555 Smart Plaza, Innovation Hub',
        rating: 4.5,
        totalReviews: 156,
        specialties: ['Smartwatch', 'Mobile', 'Tablet', 'Earbuds'],
        distanceInKm: 5.2,
        description: 'Specialized in smart device repairs and accessories.',
      ),
    ];
  }

  List<Promotion> getMockPromotions() {
    return [
      Promotion(
        id: _uuid.v4(),
        title: 'AC Servicing Special',
        description: 'Get 30% off on AC servicing this summer. Limited time offer!',
        imageUrl: 'https://via.placeholder.com/400x200',
        ctaText: 'Book Now',
        validUntil: DateTime.now().add(const Duration(days: 30)),
        vendorId: '1',
        vendorName: 'Home Appliance Care',
        discountPercentage: 30,
      ),
      Promotion(
        id: _uuid.v4(),
        title: 'Mobile Screen Replacement',
        description: 'Replace your broken mobile screen at ₹999 only!',
        imageUrl: 'https://via.placeholder.com/400x200',
        ctaText: 'Get Quote',
        validUntil: DateTime.now().add(const Duration(days: 15)),
        vendorId: '2',
        vendorName: 'Tech Fix Solutions',
        discountPercentage: 25,
      ),
      Promotion(
        id: _uuid.v4(),
        title: 'Free Home Inspection',
        description: 'Get free home appliance inspection and diagnosis.',
        imageUrl: 'https://via.placeholder.com/400x200',
        ctaText: 'Schedule Now',
        validUntil: DateTime.now().add(const Duration(days: 20)),
        vendorId: '3',
        vendorName: 'Quick Repair Hub',
      ),
    ];
  }

  List<AppNotification> getMockNotifications(String userId) {
    return [
      AppNotification(
        id: _uuid.v4(),
        title: 'Repair Completed',
        message: 'Your Induction Stove repair has been completed successfully!',
        type: NotificationType.repairStatusUpdate,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
        repairId: 'repair_1',
      ),
      AppNotification(
        id: _uuid.v4(),
        title: 'Out for Delivery',
        message: 'Your repaired mobile is out for delivery and will reach you soon.',
        type: NotificationType.deliveryUpdate,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
        repairId: 'repair_2',
      ),
      AppNotification(
        id: _uuid.v4(),
        title: 'Special Offer',
        message: 'Get 30% off on AC servicing this summer!',
        type: NotificationType.promotional,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      AppNotification(
        id: _uuid.v4(),
        title: 'Waiting for Parts',
        message: 'Your TV repair is on hold. Waiting for spare parts to arrive.',
        type: NotificationType.repairStatusUpdate,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
        repairId: 'repair_3',
      ),
    ];
  }
}
