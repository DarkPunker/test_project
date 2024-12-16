import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/product.dart';
import 'package:test_project/providers/products_provider.dart';
import 'package:go_router/go_router.dart';

class BottonbarProductDetail extends StatelessWidget {
  final Product product;
  const BottonbarProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Botón para ir al perfil del vendedor
          IconButton(
              onPressed: () {
                context.push('/store_detail', extra: product.id);
              },
              icon: Icon(Icons.store)),
          // Botón p,ara iniciar chat con el vendedor
          IconButton(onPressed: () {}, icon: Icon(Icons.chat)),

          Row(
            children: [
              IconButton(
                onPressed: productProvider.decrementQuantity,
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.red,
              ),
              Text(
                '${productProvider.purchaseQuantity}',
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: () =>
                    productProvider.incrementQuantity(product.quantity),
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.green,
              ),
            ],
          ),

          CupertinoButton(
            color: Colors.blue, // Color del botón
            borderRadius: BorderRadius.circular(8.0),
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            onPressed: () {
              // Lógica para realizar la compra
              print('Comprar producto');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.shopping_cart, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Comprar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
