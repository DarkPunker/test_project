import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

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
      animationDuration: const Duration(milliseconds: 3000),
      backgroundColor: const Color(0xFFFCFFF5),
      childWidget: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/splash_logo.json', height: 300, width: 300),
          Lottie.asset('assets/loading.json'),
        ],
      )),
    );
  }
}
