// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepairModelAdapter extends TypeAdapter<RepairModel> {
  @override
  final int typeId = 0;

  @override
  RepairModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepairModel(
      id: fields[0] as String,
      productName: fields[1] as String,
      issueDescription: fields[2] as String,
      status: fields[3] as String,
      createdAt: fields[4] as DateTime,
      expectedDeliveryDate: fields[5] as DateTime,
      vendorId: fields[6] as String,
      vendorName: fields[7] as String,
      userId: fields[8] as String,
      imageUrl: fields[9] as String?,
      statusHistory: (fields[10] as List).cast<RepairStatusUpdateModel>(),
      notes: fields[11] as String?,
      estimatedCost: fields[12] as double?,
      actualCost: fields[13] as double?,
      isDelayed: fields[14] as bool,
      completedAt: fields[15] as DateTime?,
      deliveredAt: fields[16] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, RepairModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.issueDescription)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.expectedDeliveryDate)
      ..writeByte(6)
      ..write(obj.vendorId)
      ..writeByte(7)
      ..write(obj.vendorName)
      ..writeByte(8)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.statusHistory)
      ..writeByte(11)
      ..write(obj.notes)
      ..writeByte(12)
      ..write(obj.estimatedCost)
      ..writeByte(13)
      ..write(obj.actualCost)
      ..writeByte(14)
      ..write(obj.isDelayed)
      ..writeByte(15)
      ..write(obj.completedAt)
      ..writeByte(16)
      ..write(obj.deliveredAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepairModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RepairStatusUpdateModelAdapter
    extends TypeAdapter<RepairStatusUpdateModel> {
  @override
  final int typeId = 1;

  @override
  RepairStatusUpdateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepairStatusUpdateModel(
      status: fields[0] as String,
      timestamp: fields[1] as DateTime,
      notes: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RepairStatusUpdateModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepairStatusUpdateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
