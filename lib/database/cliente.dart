import 'package:hive/hive.dart';

part 'cliente.g.dart'; // Archivo generado automáticamente

@HiveType(typeId: 1) // Asignar un typeId único para el modelo
class Cliente extends HiveObject {
  @HiveField(0)
  final int cc;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String apellido;

  @HiveField(3)
  final String direccion;

  @HiveField(4)
  final String lat;

  @HiveField(5)
  final String long;

  Cliente({
    required this.cc,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.lat,
    required this.long,
  });
}