// Modelo de producto
class Product {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String categoryId;

  final double? rating;
  final String? imageUrl;
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.categoryId,
      this.rating,
      this.imageUrl});
}
