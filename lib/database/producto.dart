import 'package:hive/hive.dart';

part 'producto.g.dart'; // Archivo generado automáticamente

@HiveType(typeId: 3) // Asignar un typeId único para el modelo
class Producto extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String? unidadMedida;

  @HiveField(3)
  final int id_categoria;


  Producto({
    required this.id,
    required this.nombre,
    required this.unidadMedida,
    required this.id_categoria,
  });
}