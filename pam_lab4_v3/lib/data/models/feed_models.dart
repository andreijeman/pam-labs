// data/models/feed_models.dart

import '../../domain/entities/feed.dart';

class FeedModel {
  final String title;
  final String bannerImage;
  final List<FeedSectionModel> sections;

  FeedModel({
    required this.title,
    required this.bannerImage,
    required this.sections,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      title: json['title'] as String? ?? '',
      bannerImage: json['bannerImage'] as String? ?? '',
      sections: (json['sections'] as List<dynamic>? ?? [])
          .map((e) => FeedSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Feed toEntity() => Feed(
        title: title,
        bannerImage: bannerImage,
        sections: sections.map((e) => e.toEntity()).toList(),
      );
}

class FeedSectionModel {
  final String title;
  final String subtitle;
  final List<FeedItemModel> items;

  FeedSectionModel({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  factory FeedSectionModel.fromJson(Map<String, dynamic> json) {
    return FeedSectionModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => FeedItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  FeedSection toEntity() => FeedSection(
        title: title,
        subtitle: subtitle,
        items: items.map((e) => e.toEntity()).toList(),
      );
}

class FeedItemModel {
  final int id;
  final String brand;
  final String name;
  final String image;
  final double? oldPrice;
  final double price;
  final int? discount;
  final bool isNew;
  final double rating;
  final int reviews;
  final bool isFavorite;

  FeedItemModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.image,
    this.oldPrice,
    required this.price,
    this.discount,
    required this.isNew,
    required this.rating,
    required this.reviews,
    required this.isFavorite,
  });

  factory FeedItemModel.fromJson(Map<String, dynamic> json) {
    final hasOldPrice = json['oldPrice'] != null;
    final hasNewPrice = json['newPrice'] != null;

    double resolvePrice() {
      if (hasNewPrice) {
        return (json['newPrice'] as num).toDouble();
      }
      // fallback if price is also null -> 0
      return (json['price'] as num? ?? 0).toDouble();
    }

    return FeedItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      brand: json['brand'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      oldPrice:
          hasOldPrice ? (json['oldPrice'] as num?)?.toDouble() : null,
      price: resolvePrice(),
      discount: json['discount'] != null
          ? (json['discount'] as num?)?.toInt()
          : null,
      isNew: json['isNew'] as bool? ?? false,
      rating: (json['rating'] as num? ?? 0).toDouble(),
      reviews: (json['reviews'] as num? ?? 0).toInt(),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  FeedItem toEntity() => FeedItem(
        id: id,
        brand: brand,
        name: name,
        image: image,
        oldPrice: oldPrice,
        price: price,
        discount: discount,
        isNew: isNew,
        rating: rating,
        reviews: reviews,
        isFavorite: isFavorite,
      );
}
