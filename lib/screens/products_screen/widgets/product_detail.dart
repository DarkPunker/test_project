import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/products_provider.dart';
import 'package:test_project/screens/products_screen/widgets/bottonbar_product_detail.dart';
import 'package:go_router/go_router.dart';

class ProductDetailWidget extends StatefulWidget {
  final String productId;

  const ProductDetailWidget({
    super.key,
    required this.productId,
  });

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.products.firstWhere(
      (p) => p.id == widget.productId,
    );

    // Obtener productos similares
    final similarProducts = productProvider.products
        .where((p) => p.categoryId == product.categoryId && p.id != product.id)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar con la imagen del producto
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.name,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              background: product.imageUrl != null
                  ? Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.amber,
                      child: const Center(
                        child: Text(
                          'Sin imagen',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Precio del producto

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Calificación con estrellas
                          RatingStars(
                            value:
                                product.rating ?? 4.0, // Rating por defecto 4.0
                            onValueChanged: (v) {},
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                              size: 20,
                            ),
                            starCount: 5,
                            starSize: 20,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: false,
                            valueLabelVisibility: false,
                            animationDuration:
                                const Duration(milliseconds: 400),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.amber,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Cantidad en stock
                      Text(
                        'Stock: ${product.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Contador para cantidad a comprar
                      Text(
                        'Descripcion del producto aqui Descripcion del producto aqui Descripcion del producto aqui Descripcion del producto aquiDescripcion del producto aqui Descripcion del producto aqui.',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      // Sección de comentarios
                      const Text(
                        'Comentarios',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5, // Cambia este valor con tus datos reales
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text('Usuario $index'),
                            subtitle:
                                Text('Comentario $index sobre el producto.'),
                          );
                        },
                      ),
                      const Divider(),
                      // Sección de productos similares
                      const Text(
                        'Productos similares',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: similarProducts.length,
                          itemBuilder: (context, index) {
                            final similarProduct = similarProducts[index];
                            return InkWell(
                              onTap: () => context.push('/products_detail',
                                  extra: similarProduct.id),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              similarProduct.imageUrl ?? ''),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      similarProduct.name,
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${similarProduct.price}',
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottonbarProductDetail(
        product: product,
      ),
    );
  }
}
