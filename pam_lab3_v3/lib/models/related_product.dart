class RelatedProduct {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double? oldPrice;
  final String currency;
  final String image;

  RelatedProduct({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.currency,
    required this.image,
  });

  static double? _d(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse('$v');
  }

  factory RelatedProduct.fromMap(Map<String, dynamic> m) => RelatedProduct(
    id: m['id'] ?? '',
    title: m['title'] ?? '',
    brand: m['brand'] ?? '',
    price: _d(m['price']) ?? 0,
    oldPrice: _d(m['oldPrice']),
    currency: m['currency'] ?? '',
    image: m['image'] ?? '',
  );
}
