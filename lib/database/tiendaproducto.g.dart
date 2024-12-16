// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiendaproducto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TiendaProductoAdapter extends TypeAdapter<TiendaProducto> {
  @override
  final int typeId = 7;

  @override
  TiendaProducto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TiendaProducto(
      id: fields[0] as int,
      precio: fields[1] as int?,
      calificacion: fields[2] as double?,
      stock: fields[3] as double?,
      caracteristicas: fields[4] as String?,
      descripcion: fields[5] as String?,
      idTienda: fields[6] as int,
      idProducto: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TiendaProducto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.precio)
      ..writeByte(2)
      ..write(obj.calificacion)
      ..writeByte(3)
      ..write(obj.stock)
      ..writeByte(4)
      ..write(obj.caracteristicas)
      ..writeByte(5)
      ..write(obj.descripcion)
      ..writeByte(6)
      ..write(obj.idTienda)
      ..writeByte(7)
      ..write(obj.idProducto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TiendaProductoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
