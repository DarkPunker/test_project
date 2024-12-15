import 'package:hive/hive.dart';

part 'usuario.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject{
  @HiveField(0)
  String email;

  @HiveField(2)
  String contrasena;

  Usuario({
    required this.email,
    required this.contrasena
  });

  factory Usuario.empty() {
    return Usuario(
        email: '',
        contrasena: '',
    );
  }
}