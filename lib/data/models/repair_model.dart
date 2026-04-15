import 'package:hive/hive.dart';
import '../../domain/entities/repair.dart';

part 'repair_model.g.dart';

@HiveType(typeId: 0)
class RepairModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String issueDescription;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime expectedDeliveryDate;

  @HiveField(6)
  final String vendorId;

  @HiveField(7)
  final String vendorName;

  @HiveField(8)
  final String userId;

  @HiveField(9)
  final String? imageUrl;

  @HiveField(10)
  final List<RepairStatusUpdateModel> statusHistory;

  @HiveField(11)
  final String? notes;

  @HiveField(12)
  final double? estimatedCost;

  @HiveField(13)
  final double? actualCost;

  @HiveField(14)
  final bool isDelayed;

  @HiveField(15)
  final DateTime? completedAt;

  @HiveField(16)
  final DateTime? deliveredAt;

  RepairModel({
    required this.id,
    required this.productName,
    required this.issueDescription,
    required this.status,
    required this.createdAt,
    required this.expectedDeliveryDate,
    required this.vendorId,
    required this.vendorName,
    required this.userId,
    this.imageUrl,
    this.statusHistory = const [],
    this.notes,
    this.estimatedCost,
    this.actualCost,
    this.isDelayed = false,
    this.completedAt,
    this.deliveredAt,
  });

  factory RepairModel.fromEntity(Repair repair) {
    return RepairModel(
      id: repair.id,
      productName: repair.productName,
      issueDescription: repair.issueDescription,
      status: repair.status.name,
      createdAt: repair.createdAt,
      expectedDeliveryDate: repair.expectedDeliveryDate,
      vendorId: repair.vendorId,
      vendorName: repair.vendorName,
      userId: repair.userId,
      imageUrl: repair.imageUrl,
      statusHistory: repair.statusHistory
          .map((e) => RepairStatusUpdateModel.fromEntity(e))
          .toList(),
      notes: repair.notes,
      estimatedCost: repair.estimatedCost,
      actualCost: repair.actualCost,
      isDelayed: repair.isDelayed,
      completedAt: repair.completedAt,
      deliveredAt: repair.deliveredAt,
    );
  }

  Repair toEntity() {
    return Repair(
      id: id,
      productName: productName,
      issueDescription: issueDescription,
      status: RepairStatus.values.firstWhere((e) => e.name == status),
      createdAt: createdAt,
      expectedDeliveryDate: expectedDeliveryDate,
      vendorId: vendorId,
      vendorName: vendorName,
      userId: userId,
      imageUrl: imageUrl,
      statusHistory: statusHistory.map((e) => e.toEntity()).toList(),
      notes: notes,
      estimatedCost: estimatedCost,
      actualCost: actualCost,
      isDelayed: isDelayed,
      completedAt: completedAt,
      deliveredAt: deliveredAt,
    );
  }

  factory RepairModel.fromJson(Map<String, dynamic> json) {
    return RepairModel(
      id: json['id'] as String,
      productName: json['productName'] as String,
      issueDescription: json['issueDescription'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expectedDeliveryDate: DateTime.parse(json['expectedDeliveryDate'] as String),
      vendorId: json['vendorId'] as String,
      vendorName: json['vendorName'] as String,
      userId: json['userId'] as String,
      imageUrl: json['imageUrl'] as String?,
      statusHistory: (json['statusHistory'] as List<dynamic>?)
              ?.map((e) => RepairStatusUpdateModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      notes: json['notes'] as String?,
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble(),
      actualCost: (json['actualCost'] as num?)?.toDouble(),
      isDelayed: json['isDelayed'] as bool? ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'issueDescription': issueDescription,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'expectedDeliveryDate': expectedDeliveryDate.toIso8601String(),
      'vendorId': vendorId,
      'vendorName': vendorName,
      'userId': userId,
      'imageUrl': imageUrl,
      'statusHistory': statusHistory.map((e) => e.toJson()).toList(),
      'notes': notes,
      'estimatedCost': estimatedCost,
      'actualCost': actualCost,
      'isDelayed': isDelayed,
      'completedAt': completedAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
    };
  }
}

@HiveType(typeId: 1)
class RepairStatusUpdateModel {
  @HiveField(0)
  final String status;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final String? notes;

  RepairStatusUpdateModel({
    required this.status,
    required this.timestamp,
    this.notes,
  });

  factory RepairStatusUpdateModel.fromEntity(RepairStatusUpdate update) {
    return RepairStatusUpdateModel(
      status: update.status.name,
      timestamp: update.timestamp,
      notes: update.notes,
    );
  }

  RepairStatusUpdate toEntity() {
    return RepairStatusUpdate(
      status: RepairStatus.values.firstWhere((e) => e.name == status),
      timestamp: timestamp,
      notes: notes,
    );
  }

  factory RepairStatusUpdateModel.fromJson(Map<String, dynamic> json) {
    return RepairStatusUpdateModel(
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }
}
