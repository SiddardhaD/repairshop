import 'package:equatable/equatable.dart';

class Promotion extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? ctaText;
  final String? ctaUrl;
  final DateTime validUntil;
  final String vendorId;
  final String? vendorName;
  final double? discountPercentage;

  const Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.ctaText,
    this.ctaUrl,
    required this.validUntil,
    required this.vendorId,
    this.vendorName,
    this.discountPercentage,
  });

  Promotion copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? ctaText,
    String? ctaUrl,
    DateTime? validUntil,
    String? vendorId,
    String? vendorName,
    double? discountPercentage,
  }) {
    return Promotion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      ctaText: ctaText ?? this.ctaText,
      ctaUrl: ctaUrl ?? this.ctaUrl,
      validUntil: validUntil ?? this.validUntil,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        ctaText,
        ctaUrl,
        validUntil,
        vendorId,
        vendorName,
        discountPercentage,
      ];
}
