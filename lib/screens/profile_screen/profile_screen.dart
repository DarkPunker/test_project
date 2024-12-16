import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/product.dart';
import 'package:test_project/models/store.dart';
import 'package:test_project/providers/products_provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    Store store = productProvider.getStoreByProductId('')!;

    List<Product> productByStore =
        productProvider.getProductsByIds(store.productIds);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          store.name,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff55b047),
        centerTitle: true,
        actions: [
          // Icono del logo de la tienda
          CircleAvatar(
            backgroundImage: NetworkImage(store.logoUrl),
            radius: 20,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Calificación de la tienda

                  const SizedBox(height: 16),
                  // Información de la tienda
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          store.address,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        store.phoneNumber,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () {
                          // Implementar llamada telefónica
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Redes sociales
                  Row(
                    children: store.socialLinks.map((social) {
                      return IconButton(
                        icon: Icon(
                          social.contains('instagram')
                              ? Icons.facebook
                              : Icons.link,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      );
                    }).toList(),
                  ),
                  RatingStars(
                    value: 4.7 ?? 0.0,
                    starSize: 20,
                    starColor: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(thickness: 1),
          ),
          // Productos destacados
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Productos de ${store.name}',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // En el widget ProfileScreen

          ChoiceOrderBy(productProvider: productProvider),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = productByStore[index];
                return ProductsStore(product: product);
              },
              childCount: productByStore.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceOrderBy extends StatelessWidget {
  const ChoiceOrderBy({
    super.key,
    required this.productProvider,
  });

  final ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Wrap(
          spacing: 5.0,
          runSpacing: 1.0,
          children: [
            ChoiceChip(
              labelPadding: const EdgeInsets.all(0),
              label: Text(
                'Mayor precio',
                style: GoogleFonts.montserrat(
                    fontSize: 10, fontWeight: FontWeight.w500),
              ),
              selected: productProvider.selectedFilter == 'Mayor precio',
              onSelected: (bool selected) {
                if (selected) {
                  productProvider.setFilter('Mayor precio');
                }
              },
            ),
            ChoiceChip(
              labelPadding: const EdgeInsets.all(0),
              label: Text(
                'Menor precio',
                style: GoogleFonts.montserrat(
                    fontSize: 10, fontWeight: FontWeight.w500),
              ),
              selected: productProvider.selectedFilter == 'Menor precio',
              onSelected: (bool selected) {
                if (selected) {
                  productProvider.setFilter('Menor precio');
                }
              },
            ),
            ChoiceChip(
              labelPadding: const EdgeInsets.all(0),
              label: Text(
                'Mayor calificación',
                style: GoogleFonts.montserrat(
                    fontSize: 10, fontWeight: FontWeight.w500),
              ),
              selected: productProvider.selectedFilter == 'Mayor calificación',
              onSelected: (bool selected) {
                if (selected) {
                  productProvider.setFilter('Mayor calificación');
                }
              },
            ),
            ChoiceChip(
              labelPadding: const EdgeInsets.all(0),
              label: Text(
                'Menor calificación',
                style: GoogleFonts.montserrat(
                    fontSize: 10, fontWeight: FontWeight.w500),
              ),
              selected: productProvider.selectedFilter == 'Menor calificación',
              onSelected: (bool selected) {
                if (selected) {
                  productProvider.setFilter('Menor calificación');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsStore extends StatefulWidget {
  const ProductsStore({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductsStore> createState() => _ProductsStoreState();
}

class _ProductsStoreState extends State<ProductsStore> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/products_detail', extra: widget.product.id),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          leading: widget.product.imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.product.imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.image, size: 50),
          title: Text(widget.product.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  /*    RatingStars(
                    value: product.rating ?? 0.0,
                    starSize: 20,
                    starColor: Colors.amber,
                  ),*/
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              // Implementar agregar al carrito
            },
          ),
        ),
      ),
    );
  }
}
