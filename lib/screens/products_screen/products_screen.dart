import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  final ScrollController scrollController;
  const ProductsScreen({
    super.key,
    required this.scrollController,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: 100, // O la cantidad de productos que necesites
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Producto $index'),
        );
      },
    );
  }
}
