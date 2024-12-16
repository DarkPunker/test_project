import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_project/screens/login_screen/widgets/button_login.dart';
import 'package:test_project/screens/login_screen/widgets/textfield_login.dart';
import 'package:test_project/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  final GlobalKey<FormState> formKey = GlobalKey();
  FocusNode? emailFocusNode;
  FocusNode? passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    // final model = Provider.of<AuthProvider>(context, listen: true);
    EdgeInsets paddingPage = EdgeInsets.only(
      left: responsive.isTablet ? responsive.wp(30) : responsive.wp(15),
      right: responsive.isTablet ? responsive.wp(30) : responsive.wp(15),
      top: responsive.hp(3),
      bottom: responsive.hp(3),
    );
    return Scaffold(
      body: SizedBox(
        height: responsive.height,
        width: responsive.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: paddingPage,
                  child: Column(
                    children: [
                      Lottie.asset('assets/splash_logo.json'),
                      Padding(
                        padding: EdgeInsets.only(bottom: responsive.hp(5)),
                        child: Column(
                          children: [
                            Text(
                              'Ingresar',
                            ),
                            Text(
                              'Ingresa tus datos y accede a la cuenta',
                            )
                          ],
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(children: [
                          TextformFieldWidgetLogin(
                            usernameFocusNode: emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              //        model.email = text.trim();
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Escribe tu Correo Electrónico';
                              }
                              // Expresión regular para validar un correo electrónico
                              String pattern =
                                  r'^[a-zA-Z0-9.a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                              RegExp regExp = RegExp(pattern);
                              if (!regExp.hasMatch(text.trim())) {
                                return 'Ingresa un Correo Electrónico válido';
                              }
                              return null;
                            },
                            label: "Correo Electrónico",
                          ),
                          TextformFieldWidgetLogin(
                            obscureText: true,
                            usernameFocusNode: passwordFocusNode,
                            keyboardType: TextInputType.text,
                            icon: const Icon(
                              Icons.remove_red_eye_sharp,
                              color: Color.fromRGBO(107, 115, 91, 1),
                            ),
                            onChanged: (text) {
                              //      model.password = text.trim();
                            },
                            validator: (text) {
                              if (text!.trim().isEmpty) {
                                return "Escribe tu Contraseña";
                              }
                              if (text.length < 5) {
                                return "Escribe una Contraseña valida";
                              }
                              return null;
                            },
                            label: "Contraseña",
                          ),
                        ]),
                      ),
                      /*    ButtonWidgetLogin(
                          text: 'Iniciar Sesión',
                          onPressed: () =>
                              model.checkCredentialLogin(context, formKey)),*/
                      Padding(
                        padding: EdgeInsets.only(
                            top: responsive.isTablet ? responsive.hp(2) : 5,
                            bottom: responsive.isTablet ? responsive.hp(2) : 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No tienes cuenta?',
                            ),
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).push('/register');
                              },
                              child: Text(
                                'Registrate aquí',
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).push('/forgetPassword');
                          },
                          child: Text('¿Olvidaste la contraseña?',
                              style: GoogleFonts.montserrat(
                                  color: const Color(0xFF0066FF),
                                  fontWeight: FontWeight.w600,
                                  fontSize: responsive.isTablet ? 15 : 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
