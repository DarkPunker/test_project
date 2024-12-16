import 'package:flutter/material.dart';
import 'package:test_project/models/category.dart';
import 'package:test_project/models/product.dart';
import 'package:test_project/models/store.dart';

class ProfileProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];

  List<Product> get products => _products;
  List<Category> get categories => _categories;

  // Cargar categorías
  void setCategories(List<Category> categories) {
    _categories = categories;
    //  notifyListeners();
  }

  // Cargar productos
  void setProducts(List<Product> products) {
    _products = products;
    // notifyListeners();
  }

  // Filtrar productos por nombre
  List<Product> getFilteredAndPrioritizedProducts(String searchQuery) {
    final lowerCaseQuery = searchQuery.toLowerCase();

    return _products.where((product) {
      return product.name.toLowerCase().contains(lowerCaseQuery);
    }).toList()
      ..sort((a, b) {
        final nameA = a.name.toLowerCase();
        final nameB = b.name.toLowerCase();

        final startsWithA = nameA.startsWith(lowerCaseQuery);
        final startsWithB = nameB.startsWith(lowerCaseQuery);

        if (startsWithA && !startsWithB) {
          return -1; // Prioridad para productos que comienzan con el texto
        } else if (!startsWithA && startsWithB) {
          return 1;
        }
        return nameA.compareTo(nameB); // Orden alfabético secundario
      });
  }

  // Obtener productos filtrados para una categoría
  List<Product> getProductsForCategory(Category category, String searchQuery) {
    final filteredProducts = getFilteredAndPrioritizedProducts(searchQuery);
    return filteredProducts
        .where((product) => product.categoryId == category.id)
        .toList();
  }

  List<Product> getProductsByCategoryId(String categoryId, String searchQuery) {
    // Filtrar productos por categoría
    final categoryProducts = _products.where((product) {
      return product.categoryId == categoryId;
    }).toList();

    // Filtrar por búsqueda
    final filteredProducts = categoryProducts.where((product) {
      return product.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase().trim());
    }).toList();

    return filteredProducts;
  }

  String getIdCategory(String name) {
    return _categories.firstWhere((test) => test.name == name).id;
  }

  String getNameCategory(String id) {
    return _categories.firstWhere((test) => test.id == id).name;
  }

  int _purchaseQuantity = 1;

  get purchaseQuantity => _purchaseQuantity;

  void incrementQuantity(int stockQuantity) {
    if (purchaseQuantity < stockQuantity) {
      _purchaseQuantity++;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (purchaseQuantity > 1) {
      _purchaseQuantity--;
      notifyListeners();
    }
  }

  List<Store> _stores = [];

  List<Store> get stores => _stores;

  // Cargar tiendas
  void setStores(List<Store> stores) {
    _stores = stores;
    //notifyListeners();
  }

  // Buscar la tienda asociada a un producto
  Store? getStoreByProductId(String productId) {
    return _stores.firstWhere(
      (store) => store.productIds.contains(productId),
    );
  }

  List<Product> getProductsByIds(List<String> productIds) {
    return _products
        .where((product) => productIds.contains(product.id))
        .toList();
  }

  String _selectedFilter = 'Mayor precio'; // Filtro por defecto

  String get selectedFilter => _selectedFilter;

  // Métodos de ordenación
  void sortProducts() {
    if (_selectedFilter == 'Mayor precio') {
      _products.sort((a, b) => b.price.compareTo(a.price));
    } else if (_selectedFilter == 'Menor precio') {
      _products.sort((a, b) => a.price.compareTo(b.price));
    } else if (_selectedFilter == 'Mayor calificación') {
      _products.sort((a, b) => b.rating!.compareTo(a.rating!));
    } else if (_selectedFilter == 'Menor calificación') {
      _products.sort((a, b) => a.rating!.compareTo(b.rating!));
    }
    notifyListeners(); // Notificar a los widgets para que se actualicen
  }

  // Cambiar el filtro seleccionado y volver a ordenar los productos
  void setFilter(String filter) {
    _selectedFilter = filter;
    sortProducts(); // Ordenamos los productos según el nuevo filtro
    notifyListeners(); // Notificar a los widgets para que se actualicen
  }
}
