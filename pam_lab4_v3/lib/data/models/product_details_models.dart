// data/models/product_details_models.dart

import '../../domain/entities/product.dart';

class ProductDetailsModel {
  final ProductModel product;

  ProductDetailsModel({required this.product});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      product: ProductModel.fromJson(
        json['product'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  Product toEntity() => product.toEntity();
}

class ProductModel {
  final String id;
  final String title;
  final String brand;
  final String description;
  final double price;
  final String currency;
  final double rating;
  final int reviewsCount;
  final List<ProductColorModel> colors;
  final List<String> sizes;
  final ShippingInfoModel shippingInfo;
  final SupportInfoModel support;
  final ProductActionsModel actions;
  final List<RelatedProductModel> relatedProducts;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num? ?? 0).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      rating: (json['rating'] as num? ?? 0).toDouble(),
      reviewsCount: (json['reviewsCount'] as num? ?? 0).toInt(),
      colors: (json['colors'] as List<dynamic>? ?? [])
          .map((e) => ProductColorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      shippingInfo: ShippingInfoModel.fromJson(
        json['shippingInfo'] as Map<String, dynamic>? ?? const {},
      ),
      support: SupportInfoModel.fromJson(
        json['support'] as Map<String, dynamic>? ?? const {},
      ),
      actions: ProductActionsModel.fromJson(
        json['actions'] as Map<String, dynamic>? ?? const {},
      ),
      relatedProducts: (json['relatedProducts'] as List<dynamic>? ?? [])
          .map((e) => RelatedProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Product toEntity() => Product(
        id: id,
        title: title,
        brand: brand,
        description: description,
        price: price,
        currency: currency,
        rating: rating,
        reviewsCount: reviewsCount,
        colors: colors.map((e) => e.toEntity()).toList(),
        sizes: sizes,
        shippingInfo: shippingInfo.toEntity(),
        support: support.toEntity(),
        actions: actions.toEntity(),
        relatedProducts: relatedProducts.map((e) => e.toEntity()).toList(),
      );
}

class ProductColorModel {
  final String name;
  final String hex;
  final List<String> images;

  ProductColorModel({
    required this.name,
    required this.hex,
    required this.images,
  });

  factory ProductColorModel.fromJson(Map<String, dynamic> json) {
    return ProductColorModel(
      name: json['name'] as String? ?? '',
      hex: json['hex'] as String? ?? '#000000',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  ProductColor toEntity() => ProductColor(
        name: name,
        hex: hex,
        images: images,
      );
}

class ShippingInfoModel {
  final String delivery;
  final String returns;

  ShippingInfoModel({
    required this.delivery,
    required this.returns,
  });

  factory ShippingInfoModel.fromJson(Map<String, dynamic> json) {
    return ShippingInfoModel(
      delivery: json['delivery'] as String? ?? '',
      returns: json['returns'] as String? ?? '',
    );
  }

  ShippingInfo toEntity() => ShippingInfo(
        delivery: delivery,
        returns: returns,
      );
}

class SupportInfoModel {
  final String contactEmail;
  final String faqUrl;

  SupportInfoModel({
    required this.contactEmail,
    required this.faqUrl,
  });

  factory SupportInfoModel.fromJson(Map<String, dynamic> json) {
    return SupportInfoModel(
      contactEmail: json['contactEmail'] as String? ?? '',
      faqUrl: json['faqUrl'] as String? ?? '',
    );
  }

  SupportInfo toEntity() => SupportInfo(
        contactEmail: contactEmail,
        faqUrl: faqUrl,
      );
}

class ProductActionsModel {
  final bool addToCart;
  final bool addToWishlist;
  final bool share;

  ProductActionsModel({
    required this.addToCart,
    required this.addToWishlist,
    required this.share,
  });

  factory ProductActionsModel.fromJson(Map<String, dynamic> json) {
    return ProductActionsModel(
      addToCart: json['addToCart'] as bool? ?? false,
      addToWishlist: json['addToWishlist'] as bool? ?? false,
      share: json['share'] as bool? ?? false,
    );
  }

  ProductActions toEntity() => ProductActions(
        addToCart: addToCart,
        addToWishlist: addToWishlist,
        share: share,
      );
}

class RelatedProductModel {
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

  RelatedProductModel({
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

  factory RelatedProductModel.fromJson(Map<String, dynamic> json) {
    return RelatedProductModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      price: (json['price'] as num? ?? 0).toDouble(),
      oldPrice:
          json['oldPrice'] != null ? (json['oldPrice'] as num).toDouble() : null,
      currency: json['currency'] as String? ?? 'USD',
      discount: json['discount'] as String?,
      rating: (json['rating'] as num? ?? 0).toDouble(),
      reviewsCount: (json['reviewsCount'] as num? ?? 0).toInt(),
      image: json['image'] as String? ?? '',
    );
  }

  RelatedProduct toEntity() => RelatedProduct(
        id: id,
        title: title,
        brand: brand,
        price: price,
        oldPrice: oldPrice,
        currency: currency,
        discount: discount,
        rating: rating,
        reviewsCount: reviewsCount,
        image: image,
      );
}
