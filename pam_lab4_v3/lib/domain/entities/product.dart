class Product {
  final String id;
  final String title;
  final String brand;
  final String description;
  final double price;
  final String currency;
  final double rating;
  final int reviewsCount;
  final List<ProductColor> colors;
  final List<String> sizes;
  final ShippingInfo shippingInfo;
  final SupportInfo support;
  final ProductActions actions;
  final List<RelatedProduct> relatedProducts;

  Product({
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
    required this.shippingInfo,
    required this.support,
    required this.actions,
    required this.relatedProducts,
  });
}

class ProductColor {
  final String name;
  final String hex;
  final List<String> images;

  ProductColor({
    required this.name,
    required this.hex,
    required this.images,
  });
}

class ShippingInfo {
  final String delivery;
  final String returns;

  ShippingInfo({
    required this.delivery,
    required this.returns,
  });
}

class SupportInfo {
  final String contactEmail;
  final String faqUrl;

  SupportInfo({
    required this.contactEmail,
    required this.faqUrl,
  });
}

class ProductActions {
  final bool addToCart;
  final bool addToWishlist;
  final bool share;

  ProductActions({
    required this.addToCart,
    required this.addToWishlist,
    required this.share,
  });
}

class RelatedProduct {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double? oldPrice;
  final String currency;
  final String? discount;
  final double rating;
  final int reviewsCount;
  final String image;

  RelatedProduct({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.currency,
    this.discount,
    required this.rating,
    required this.reviewsCount,
    required this.image,
  });
}