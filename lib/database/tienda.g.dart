// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tienda.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TiendaAdapter extends TypeAdapter<Tienda> {
  @override
  final int typeId = 2;

  @override
  Tienda read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tienda(
      id: fields[0] as int,
      nombre: fields[1] as String,
      redes: fields[2] as String?,
      celular: fields[3] as int,
      direccion: fields[4] as String,
      lat: fields[5] as String,
      long: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tienda obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.redes)
      ..writeByte(3)
      ..write(obj.celular)
      ..writeByte(4)
      ..write(obj.direccion)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TiendaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
