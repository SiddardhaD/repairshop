import 'package:equatable/equatable.dart';

class Vendor extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String address;
  final double rating;
  final int totalReviews;
  final String? imageUrl;
  final List<String> specialties;
  final double distanceInKm;
  final bool isAvailable;
  final String? description;

  const Vendor({
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

  Vendor copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    double? rating,
    int? totalReviews,
    String? imageUrl,
    List<String>? specialties,
    double? distanceInKm,
    bool? isAvailable,
    String? description,
  }) {
    return Vendor(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      imageUrl: imageUrl ?? this.imageUrl,
      specialties: specialties ?? this.specialties,
      distanceInKm: distanceInKm ?? this.distanceInKm,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        address,
        rating,
        totalReviews,
        imageUrl,
        specialties,
        distanceInKm,
        isAvailable,
        description,
      ];
}
