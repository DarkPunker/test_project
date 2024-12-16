import 'package:flutter/material.dart';
import 'package:test_project/models/category.dart';
import 'package:test_project/providers/products_provider.dart';
import 'package:go_router/go_router.dart';

class NameCategoryWidget extends StatelessWidget {
  final Category category;
  final bool isEmpty;
  const NameCategoryWidget(
      {super.key, required this.category, required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            category.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (!isEmpty)
          TextButton(
            onPressed: () =>
                context.push('/products_category', extra: category.id),
            child: Text(
              ' Ver más productos',
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
