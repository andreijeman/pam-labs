class Product {
  final int id;
  final String brand;
  final String name;
  final String image;
  final double? oldPrice;
  final double? newPrice;
  final double? price;
  final int? discount;
  final bool? isNew;
  final double rating;
  final int reviews;
  final bool isFavorite;

  Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.image,
    this.oldPrice,
    this.newPrice,
    this.price,
    this.discount,
    this.isNew,
    required this.rating,
    required this.reviews,
    required this.isFavorite,
  });

  Product copyWith({bool? isFavorite}) => Product(
    id: id,
    brand: brand,
    name: name,
    image: image,
    oldPrice: oldPrice,
    newPrice: newPrice,
    price: price,
    discount: discount,
    isNew: isNew,
    rating: rating,
    reviews: reviews,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  static double? _d(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  factory Product.fromMap(Map<String, dynamic> m) => Product(
    id: m['id'] is String ? int.tryParse(m['id']) ?? 0 : (m['id'] ?? 0),
    brand: m['brand'] ?? '',
    name: m['name'] ?? '',
    image: m['image'] ?? '',
    oldPrice: _d(m['oldPrice']),
    newPrice: _d(m['newPrice']),
    price: _d(m['price']),
    discount: m['discount'] is String
        ? int.tryParse(m['discount'].toString().replaceAll(RegExp(r'[^0-9]'), ''))
        : m['discount'],
    isNew: m['isNew'],
    rating: _d(m['rating']) ?? 0,
    reviews: m['reviews'] ?? m['reviewsCount'] ?? 0,
    isFavorite: m['isFavorite'] ?? false,
  );
}
