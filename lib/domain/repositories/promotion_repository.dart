import '../entities/promotion.dart';

abstract class PromotionRepository {
  Future<List<Promotion>> getActivePromotions();
  Future<Promotion?> getPromotionById(String id);
  Future<List<Promotion>> getVendorPromotions(String vendorId);
}
