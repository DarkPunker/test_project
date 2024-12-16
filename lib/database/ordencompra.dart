import 'package:hive/hive.dart';

part 'ordencompra.g.dart'; 

@HiveType(typeId: 5)
class OrdenCompra extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String? comentario;

  @HiveField(2)
  double? cantidad;

  @HiveField(3)
  double? calificacion;

  @HiveField(4)
  int? estado;

  @HiveField(5)
  int? ccCliente;

  @HiveField(6)
  int? idTiendaProducto;

  OrdenCompra({
    required this.id,
    this.comentario,
    this.cantidad,
    this.calificacion,
    this.estado,
    this.ccCliente,
    this.idTiendaProducto,
  });
}