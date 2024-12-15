import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/screens/chat_ia_screen/chat_ia_screen.dart';
import 'package:test_project/screens/navigation_screen.dart';
import 'package:test_project/screens/products_screen/widgets/glb_model_viewer.dart';
import 'package:test_project/screens/splash_screen.dart';

final GoRouter router = GoRouter(
    initialLocation: '/splash',
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: const SplashScreen(),
      );
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/navigation',
        builder: (context, state) => const NavigationScreen(),
      ),
      GoRoute(
        path: '/chat_ia',
        builder: (context, state) => const ChatIaScreen(),
      ),
      GoRoute(
        path: '/viewer',
        builder: (context, state) => const GLBModelViewer(
          modelPath: 'assets/banana.glb',
        ),
      ),
    ]);
