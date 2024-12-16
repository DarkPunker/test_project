import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/product.dart';
import 'package:test_project/providers/products_provider.dart';

class CategoryProductList extends StatefulWidget {
  final String categoryId;

  const CategoryProductList({
    super.key,
    required this.categoryId,
  });

  @override
  State<CategoryProductList> createState() => _CategoryProductListState();
}

class _CategoryProductListState extends State<CategoryProductList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    List<Product> products =
        productProvider.getProductsByCategoryId(widget.categoryId, searchQuery);
    String nameCategory = productProvider.getNameCategory(widget.categoryId);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff55b047),
        title: Text(nameCategory,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Material(
                elevation: 4, // Sombra alrededor del widget
                borderRadius: BorderRadius.circular(30), // Bordes redondeados
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Buscar',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder
                        .none, // Sin bordes definidos, manejado por el Material
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
              ),
            ),
            products.isEmpty
                ? const Center(
                    child:
                        Text('No hay productos disponibles en esta categoría'))
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columnas
                        crossAxisSpacing: 10, // Espacio entre las columnas
                        mainAxisSpacing: 10, // Espacio entre las filas
                        childAspectRatio:
                            0.75, // Aspecto de cada celda (ajusta el tamaño)
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return ProductCard(product: product);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,

      borderRadius: BorderRadius.circular(5), // Bordes redondeados
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre del producto

          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: NetworkImage(product.imageUrl ?? ''),
                fit: BoxFit.cover,
              ),
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
          const SizedBox(height: 8),
          // Precio del producto
          Text(
            '\$${product.price}',
            style: const TextStyle(fontSize: 14, color: Colors.green),
          ),
          const SizedBox(height: 8),
          // Cantidad disponible
          Text(
            'Cantidad: ${product.quantity}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
