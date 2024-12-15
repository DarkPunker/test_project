import 'package:hive/hive.dart';

part 'tienda.g.dart'; // Archivo generado automáticamente

@HiveType(typeId: 2) // Asignar un typeId único para el modelo
class Tienda extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String? redes;

  @HiveField(3)
  final int celular;

  @HiveField(4)
  final String direccion;

  @HiveField(5)
  final String lat;

  @HiveField(6)
  final String long;

  Tienda({
    required this.id,
    required this.nombre,
    this.redes,
    required this.celular,
    required this.direccion,
    required this.lat,
    required this.long,
  });
}
