import 'package:hive/hive.dart';

part 'tiendaproducto.g.dart'; 

@HiveType(typeId: 7)
class TiendaProducto extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int? precio;

  @HiveField(2)
  double? calificacion;

  @HiveField(3)
  double? stock;

  @HiveField(4)
  String? caracteristicas;

  @HiveField(5)
  String? descripcion;

  @HiveField(6)
  int idTienda;

  @HiveField(7)
  int idProducto;

  TiendaProducto({
    required this.id,
    this.precio,
    this.calificacion,
    this.stock,
    this.caracteristicas,
    this.descripcion,
    required this.idTienda,
    required this.idProducto,
  });
}