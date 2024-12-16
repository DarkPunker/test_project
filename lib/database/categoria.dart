import 'package:hive/hive.dart';

part 'categoria.g.dart';

@HiveType(typeId: 4)
class Categoria extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nombre;

  @HiveField(2)
  int? idTienda;

  Categoria({required this.id, required this.nombre, this.idTienda});
}