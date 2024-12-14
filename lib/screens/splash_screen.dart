import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      onAnimationEnd: () {
        context.go('/navigation');
      },
      backgroundColor: const Color(0xFFFCFFF5),
      childWidget: const Center(child: Icon(Icons.grass)),
    );
  }
}
