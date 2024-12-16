import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/category.dart';
import 'package:test_project/models/product.dart';
import 'package:test_project/models/store.dart';
import 'package:test_project/providers/products_provider.dart';
import 'package:test_project/screens/products_screen/product_category_screen.dart';
import 'package:test_project/screens/products_screen/widgets/list_products_widget.dart';
import 'package:test_project/screens/products_screen/widgets/name_category_widget.dart';

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
  String searchQuery = '';

  // Cargar los datos al iniciar la pantalla
  void loadData(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    productProvider.setStores([
      Store(
        id: 'store1',
        name: 'Tienda 1',
        logoUrl: 'https://via.placeholder.com/200',
        phoneNumber: '123456789',
        address: 'Dirección 1',
        latitude: -12.0464,
        longitude: -77.0428,
        socialLinks: ['https://facebook.com/tienda1'],
        productIds: ['1', '12', '13', '14', '15'], // Asociada al Producto A
      ),
      Store(
        id: 'store2',
        name: 'Tienda 2',
        logoUrl: 'https://via.placeholder.com/200',
        phoneNumber: '987654321',
        address: 'Dirección 2',
        latitude: -12.0464,
        longitude: -77.0428,
        socialLinks: ['https://instagram.com/tienda2'],
        productIds: ['2', '12', '13', '14', '15'], // Asociada al Producto B
      ),
    ]);

    // Cargar categorías
    productProvider.setCategories([
      Category(id: '1', name: 'Electrónica'),
      Category(id: '2', name: 'Hogar'),
      Category(id: '3', name: 'Deportes'),
      Category(id: '4', name: 'Ropa'),
      Category(id: '5', name: 'Alimentos'),
      Category(id: '6', name: 'Muebles'),
    ]);

// Cargar productos
    productProvider.setProducts([
      // Electrónica

      Product(
        id: '1',
        name: 'Producto A',
        price: 19.99,
        imageUrl: 'https://via.placeholder.com/150',
        quantity: 10,
        categoryId: '1',
      ),
      Product(
        id: '2',
        name: 'Producto B',
        price: 29.99,
        imageUrl: 'https://via.placeholder.com/150',
        quantity: 5,
        categoryId: '1',
      ),

      // Hogar
      Product(
        id: '11',
        name: 'Silla',
        price: 50,
        quantity: 20,
        categoryId: '2',
      ),
      Product(id: '12', name: 'Mesa', price: 150, quantity: 8, categoryId: '2'),
      Product(
          id: '13', name: 'Lámpara', price: 40, quantity: 30, categoryId: '2'),
      Product(
          id: '14', name: 'Alfombra', price: 60, quantity: 10, categoryId: '2'),
      Product(
          id: '15', name: 'Cortinas', price: 30, quantity: 25, categoryId: '2'),
      Product(
          id: '16', name: 'Cojín', price: 15, quantity: 35, categoryId: '2'),
      Product(id: '17', name: 'Sofá', price: 300, quantity: 7, categoryId: '2'),
      Product(
          id: '18', name: 'Espejo', price: 120, quantity: 10, categoryId: '2'),
      Product(
          id: '19',
          name: 'Refrigerador',
          price: 600,
          quantity: 5,
          categoryId: '2'),
      Product(
          id: '20', name: 'Lavadora', price: 350, quantity: 4, categoryId: '2'),

      // Deportes
      Product(
          id: '21',
          name: 'Pelota de fútbol',
          price: 15,
          quantity: 50,
          categoryId: '3'),
      Product(
          id: '22',
          name: 'Raqueta de tenis',
          price: 80,
          quantity: 10,
          categoryId: '3'),
      Product(
          id: '23',
          name: 'Zapatillas deportivas',
          price: 60,
          quantity: 30,
          categoryId: '3'),
      Product(
          id: '24',
          name: 'Bicicleta',
          price: 200,
          quantity: 7,
          categoryId: '3'),
      Product(
          id: '25',
          name: 'Guantes de boxeo',
          price: 40,
          quantity: 15,
          categoryId: '3'),
      Product(
          id: '26',
          name: 'Casco de ciclista',
          price: 50,
          quantity: 12,
          categoryId: '3'),
      Product(
          id: '27',
          name: 'Pantalones deportivos',
          price: 35,
          quantity: 20,
          categoryId: '3'),
      Product(
          id: '28',
          name: 'Balón de baloncesto',
          price: 25,
          quantity: 40,
          categoryId: '3'),
      Product(
          id: '29',
          name: 'Kit de yoga',
          price: 30,
          quantity: 18,
          categoryId: '3'),
      Product(
          id: '30',
          name: 'Raqueta de badminton',
          price: 45,
          quantity: 10,
          categoryId: '3'),

      // Ropa
      Product(
          id: '31', name: 'Camiseta', price: 20, quantity: 50, categoryId: '4'),
      Product(
          id: '32', name: 'Jeans', price: 40, quantity: 30, categoryId: '4'),
      Product(
          id: '33', name: 'Chaqueta', price: 80, quantity: 15, categoryId: '4'),
      Product(
          id: '34', name: 'Sombrero', price: 25, quantity: 20, categoryId: '4'),
      Product(
          id: '35', name: 'Bufanda', price: 10, quantity: 25, categoryId: '4'),
      Product(
          id: '36', name: 'Botines', price: 60, quantity: 12, categoryId: '4'),
      Product(
          id: '37', name: 'Guantes', price: 15, quantity: 35, categoryId: '4'),
      Product(
          id: '38',
          name: 'Pantalón de chándal',
          price: 30,
          quantity: 20,
          categoryId: '4'),
      Product(
          id: '39', name: 'Abrigo', price: 120, quantity: 8, categoryId: '4'),
      Product(
          id: '40', name: 'Vestido', price: 50, quantity: 18, categoryId: '4'),

      // Alimentos
      Product(
          id: '41', name: 'Manzanas', price: 2, quantity: 200, categoryId: '5'),
      Product(id: '42', name: 'Pan', price: 1, quantity: 300, categoryId: '5'),
      Product(
          id: '43', name: 'Leche', price: 1.5, quantity: 150, categoryId: '5'),
      Product(
          id: '44', name: 'Arroz', price: 2.5, quantity: 100, categoryId: '5'),
      Product(
          id: '45', name: 'Carne', price: 10, quantity: 80, categoryId: '5'),
      Product(
          id: '46', name: 'Pollo', price: 6, quantity: 150, categoryId: '5'),
      Product(
          id: '47', name: 'Pasta', price: 3, quantity: 200, categoryId: '5'),
      Product(
          id: '48', name: 'Aceite', price: 5, quantity: 120, categoryId: '5'),
      Product(id: '49', name: 'Queso', price: 7, quantity: 50, categoryId: '5'),
      Product(
          id: '50', name: 'Verduras', price: 4, quantity: 300, categoryId: '5'),

      // Muebles
      Product(
          id: '51', name: 'Sofá', price: 300, quantity: 10, categoryId: '6'),
      Product(id: '52', name: 'Cama', price: 400, quantity: 5, categoryId: '6'),
      Product(
          id: '53',
          name: 'Mesita de noche',
          price: 60,
          quantity: 20,
          categoryId: '6'),
      Product(
          id: '54',
          name: 'Escritorio',
          price: 120,
          quantity: 15,
          categoryId: '6'),
      Product(
          id: '55', name: 'Armario', price: 250, quantity: 8, categoryId: '6'),
      Product(
          id: '56',
          name: 'Silla de oficina',
          price: 100,
          quantity: 25,
          categoryId: '6'),
      Product(
          id: '57',
          name: 'Estantería',
          price: 70,
          quantity: 12,
          categoryId: '6'),
      Product(
          id: '58',
          name: 'Mesa de comedor',
          price: 150,
          quantity: 20,
          categoryId: '6'),
      Product(
          id: '59', name: 'Banco', price: 30, quantity: 30, categoryId: '6'),
      Product(
          id: '60',
          name: 'Lámpara de pie',
          price: 40,
          quantity: 18,
          categoryId: '6'),
    ]);
  }

  String selectedCategory = 'Todas';
  @override
  void initState() {
    super.initState();
    // Llamar a la función para cargar los datos cuando la pantalla se inicia
    loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                hintText: 'Buscar por producto',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder
                    .none, // Sin bordes definidos, manejado por el Material
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            scrollDirection:
                Axis.horizontal, // Permite el desplazamiento horizontal
            child: Row(
              children: [
                // Chip para "Todas"
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    label: Text(
                      'Todas',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    selected: selectedCategory == 'Todas',
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory =
                            'Todas'; // Se selecciona o deselecciona
                      });
                    },
                  ),
                ),
                // Chips de categorías
                ...productProvider.categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      label: Text(
                        category.name,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      selected: selectedCategory == category.name,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category.name;
                        });
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        if (selectedCategory != 'Todas')
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 columnas
                crossAxisSpacing: 10, // Espacio entre las columnas
                mainAxisSpacing: 10, // Espacio entre las filas
                childAspectRatio:
                    0.75, // Aspecto de cada celda (ajusta el tamaño)
              ),
              itemCount: productProvider
                  .getProductsByCategoryId(
                      productProvider.getIdCategory(selectedCategory),
                      searchQuery)
                  .length,
              itemBuilder: (context, index) {
                final product = productProvider.getProductsByCategoryId(
                    productProvider.getIdCategory(selectedCategory),
                    searchQuery)[index];

                return ProductCard(product: product);
              },
            ),
          ),
        if (selectedCategory == 'Todas')
          Expanded(
            child: Container(
              color: const Color.fromARGB(190, 240, 239, 239),
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: productProvider.categories.length,
                itemBuilder: (context, index) {
                  final category = productProvider.categories[index];
                  final categoryProducts = productProvider
                      .getProductsForCategory(category, searchQuery);

                  // Limitar a 10 productos
                  final displayedProducts = categoryProducts.take(10).toList();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nombre de la categoría y mensaje
                            NameCategoryWidget(
                              category: category,
                              isEmpty: displayedProducts.isEmpty,
                            ),
                            if (displayedProducts.isEmpty)
                              Text(
                                'No se encontraron productos',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            // Lista horizontal de productos (con un límite de 10)
                            if (displayedProducts.isNotEmpty)
                              ListProductsWidget(
                                  displayedProducts: displayedProducts)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
