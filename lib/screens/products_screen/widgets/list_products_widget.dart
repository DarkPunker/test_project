import 'package:flutter/material.dart';
import 'package:test_project/models/product.dart';
import 'package:go_router/go_router.dart';

class ListProductsWidget extends StatelessWidget {
  final List<Product> displayedProducts;
  const ListProductsWidget({super.key, required this.displayedProducts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            displayedProducts.length + 1, // Agregar 1 para el ícono al final
        itemBuilder: (context, productIndex) {
          // Si estamos en el último índice, mostrar la flecha
          if (productIndex == displayedProducts.length) {
            return const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
                size: 16,
              ),
            );
          }

          final product = displayedProducts[productIndex];
          return InkWell(
            onTap: () => context.push('/products_detail', extra: product.id),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\$${product.quantity}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
