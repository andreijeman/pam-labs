import 'details_color.dart';

class ProductDetails {
  final String id;
  final String title;
  final String brand;
  final String description;
  final double price;
  final String currency;
  final double rating;
  final int reviewsCount;
  final List<DetailsColor> colors;
  final List<String> sizes;

  ProductDetails({
    required this.id,
    required this.title,
    required this.brand,
    required this.description,
    required this.price,
    required this.currency,
    required this.rating,
    required this.reviewsCount,
    required this.colors,
    required this.sizes,
  });

  static double _d(dynamic v) => v is num ? v.toDouble() : double.tryParse('$v') ?? 0;

  factory ProductDetails.fromMap(Map<String, dynamic> raw) {
    final m = raw['product'] ?? raw;
    return ProductDetails(
      id: m['id'] ?? '',
      title: m['title'] ?? '',
      brand: m['brand'] ?? '',
      description: m['description'] ?? '',
      price: _d(m['price']),
      currency: m['currency'] ?? '',
      rating: _d(m['rating']),
      reviewsCount: m['reviewsCount'] ?? 0,
      colors: (m['colors'] as List? ?? []).map((e) => DetailsColor.fromMap(e)).toList(),
      sizes: (m['sizes'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }
}
