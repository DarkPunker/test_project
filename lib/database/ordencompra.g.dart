// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordencompra.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdenCompraAdapter extends TypeAdapter<OrdenCompra> {
  @override
  final int typeId = 5;

  @override
  OrdenCompra read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrdenCompra(
      id: fields[0] as int,
      comentario: fields[1] as String?,
      cantidad: fields[2] as double?,
      calificacion: fields[3] as double?,
      estado: fields[4] as int?,
      ccCliente: fields[5] as int?,
      idTiendaProducto: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, OrdenCompra obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.comentario)
      ..writeByte(2)
      ..write(obj.cantidad)
      ..writeByte(3)
      ..write(obj.calificacion)
      ..writeByte(4)
      ..write(obj.estado)
      ..writeByte(5)
      ..write(obj.ccCliente)
      ..writeByte(6)
      ..write(obj.idTiendaProducto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdenCompraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
