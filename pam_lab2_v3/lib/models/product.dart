class Product {
  final String title;
  final String brand;
  final String image;
  final double price;
  final double? oldPrice;
  final double? discount;
  final bool isNew;

  Product({
    required this.title,
    required this.brand,
    required this.image,
    required this.price,
    this.oldPrice,
    this.discount,
    this.isNew = false,
  });
}
