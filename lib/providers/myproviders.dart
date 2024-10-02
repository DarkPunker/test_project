import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/services/map_service.dart';

class MyProviders extends StatelessWidget {
  final Widget child;

  MyProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapService()),
      ],
      child: child,
    );
  }
}