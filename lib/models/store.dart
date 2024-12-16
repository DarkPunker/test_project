class Store {
  final String id;
  final String name;
  final String logoUrl;
  final String phoneNumber;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> socialLinks; // URLs de redes sociales
  final List<String> productIds; // IDs de productos asociados a esta tienda

  Store({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.socialLinks,
    required this.productIds,
  });
}
