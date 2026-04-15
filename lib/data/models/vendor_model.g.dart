// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VendorModelAdapter extends TypeAdapter<VendorModel> {
  @override
  final int typeId = 3;

  @override
  VendorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VendorModel(
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String,
      email: fields[3] as String?,
      address: fields[4] as String,
      rating: fields[5] as double,
      totalReviews: fields[6] as int,
      imageUrl: fields[7] as String?,
      specialties: (fields[8] as List).cast<String>(),
      distanceInKm: fields[9] as double,
      isAvailable: fields[10] as bool,
      description: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VendorModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.totalReviews)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.specialties)
      ..writeByte(9)
      ..write(obj.distanceInKm)
      ..writeByte(10)
      ..write(obj.isAvailable)
      ..writeByte(11)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
