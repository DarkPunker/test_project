import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:test_project/screens/chat_ia_screen/chat_ia_screen.dart';
import 'package:test_project/screens/chat_screen/channel_page.dart';
import 'package:test_project/screens/navigation_screen.dart';
import 'package:test_project/screens/products_screen/product_category_screen.dart';
import 'package:test_project/screens/products_screen/widgets/glb_model_viewer.dart';
import 'package:test_project/screens/products_screen/widgets/list_products_widget.dart';
import 'package:test_project/screens/products_screen/widgets/product_detail.dart';
import 'package:test_project/screens/splash_screen.dart';
import 'package:test_project/screens/store_screen/store_screen.dart';

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
        builder: (context, state) => ChatbotScreen(),
      ),
      GoRoute(
        path: '/viewer',
        builder: (context, state) => const GLBModelViewer(
          modelPath: 'assets/banana.glb',
        ),
      ),
      GoRoute(
        path: '/channelpage',
        builder: (context, state) {
          final channel = state.extra as Channel; // Obtener el canal de 'extra'
          return Scaffold(
            body: StreamChannel(
              channel: channel,
              child: const ChannelPage(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/products_category',
        builder: (context, state) => CategoryProductList(
          categoryId: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/products_detail',
        builder: (context, state) => ProductDetailWidget(
          productId: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/store_detail',
        builder: (context, state) => StoreDetailWidget(
          idProduct: state.extra as String,
        ),
      ),
    ]);
