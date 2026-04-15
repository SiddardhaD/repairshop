import 'package:equatable/equatable.dart';

enum RepairStatus {
  received,
  diagnosing,
  waitingForParts,
  repairing,
  completed,
  outForDelivery,
  delivered;

  String get displayName {
    switch (this) {
      case RepairStatus.received:
        return 'Received';
      case RepairStatus.diagnosing:
        return 'Diagnosing';
      case RepairStatus.waitingForParts:
        return 'Waiting for Parts';
      case RepairStatus.repairing:
        return 'Repairing';
      case RepairStatus.completed:
        return 'Completed';
      case RepairStatus.outForDelivery:
        return 'Out for Delivery';
      case RepairStatus.delivered:
        return 'Delivered';
    }
  }

  double get progress {
    switch (this) {
      case RepairStatus.received:
        return 0.14;
      case RepairStatus.diagnosing:
        return 0.28;
      case RepairStatus.waitingForParts:
        return 0.42;
      case RepairStatus.repairing:
        return 0.71;
      case RepairStatus.completed:
        return 0.85;
      case RepairStatus.outForDelivery:
        return 0.95;
      case RepairStatus.delivered:
        return 1.0;
    }
  }
}

class Repair extends Equatable {
  final String id;
  final String productName;
  final String issueDescription;
  final RepairStatus status;
  final DateTime createdAt;
  final DateTime expectedDeliveryDate;
  final String vendorId;
  final String vendorName;
  final String userId;
  final String? imageUrl;
  final List<RepairStatusUpdate> statusHistory;
  final String? notes;
  final double? estimatedCost;
  final double? actualCost;
  final bool isDelayed;
  final DateTime? completedAt;
  final DateTime? deliveredAt;

  const Repair({
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

  Repair copyWith({
    String? id,
    String? productName,
    String? issueDescription,
    RepairStatus? status,
    DateTime? createdAt,
    DateTime? expectedDeliveryDate,
    String? vendorId,
    String? vendorName,
    String? userId,
    String? imageUrl,
    List<RepairStatusUpdate>? statusHistory,
    String? notes,
    double? estimatedCost,
    double? actualCost,
    bool? isDelayed,
    DateTime? completedAt,
    DateTime? deliveredAt,
  }) {
    return Repair(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      issueDescription: issueDescription ?? this.issueDescription,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      statusHistory: statusHistory ?? this.statusHistory,
      notes: notes ?? this.notes,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      actualCost: actualCost ?? this.actualCost,
      isDelayed: isDelayed ?? this.isDelayed,
      completedAt: completedAt ?? this.completedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productName,
        issueDescription,
        status,
        createdAt,
        expectedDeliveryDate,
        vendorId,
        vendorName,
        userId,
        imageUrl,
        statusHistory,
        notes,
        estimatedCost,
        actualCost,
        isDelayed,
        completedAt,
        deliveredAt,
      ];
}

class RepairStatusUpdate extends Equatable {
  final RepairStatus status;
  final DateTime timestamp;
  final String? notes;

  const RepairStatusUpdate({
    required this.status,
    required this.timestamp,
    this.notes,
  });

  @override
  List<Object?> get props => [status, timestamp, notes];
}
