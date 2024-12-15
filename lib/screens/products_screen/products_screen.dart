import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final ScrollController scrollController;

  const ProductsScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController, // Vincula el controlador aquí
      itemCount: 50, // Número de elementos de ejemplo
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Producto $index'),
        );
      },
    );
  }
}
