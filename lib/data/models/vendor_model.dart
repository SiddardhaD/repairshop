import 'package:hive/hive.dart';
import '../../domain/entities/vendor.dart';

part 'vendor_model.g.dart';

@HiveType(typeId: 3)
class VendorModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String? email;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final double rating;

  @HiveField(6)
  final int totalReviews;

  @HiveField(7)
  final String? imageUrl;

  @HiveField(8)
  final List<String> specialties;

  @HiveField(9)
  final double distanceInKm;

  @HiveField(10)
  final bool isAvailable;

  @HiveField(11)
  final String? description;

  VendorModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.address,
    required this.rating,
    required this.totalReviews,
    this.imageUrl,
    this.specialties = const [],
    required this.distanceInKm,
    this.isAvailable = true,
    this.description,
  });

  factory VendorModel.fromEntity(Vendor vendor) {
    return VendorModel(
      id: vendor.id,
      name: vendor.name,
      phone: vendor.phone,
      email: vendor.email,
      address: vendor.address,
      rating: vendor.rating,
      totalReviews: vendor.totalReviews,
      imageUrl: vendor.imageUrl,
      specialties: vendor.specialties,
      distanceInKm: vendor.distanceInKm,
      isAvailable: vendor.isAvailable,
      description: vendor.description,
    );
  }

  Vendor toEntity() {
    return Vendor(
      id: id,
      name: name,
      phone: phone,
      email: email,
      address: address,
      rating: rating,
      totalReviews: totalReviews,
      imageUrl: imageUrl,
      specialties: specialties,
      distanceInKm: distanceInKm,
      isAvailable: isAvailable,
      description: description,
    );
  }

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      address: json['address'] as String,
      rating: (json['rating'] as num).toDouble(),
      totalReviews: json['totalReviews'] as int,
      imageUrl: json['imageUrl'] as String?,
      specialties: (json['specialties'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      distanceInKm: (json['distanceInKm'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool? ?? true,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'rating': rating,
      'totalReviews': totalReviews,
      'imageUrl': imageUrl,
      'specialties': specialties,
      'distanceInKm': distanceInKm,
      'isAvailable': isAvailable,
      'description': description,
    };
  }
}
