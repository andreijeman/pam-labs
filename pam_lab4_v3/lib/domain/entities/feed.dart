class Feed {
  final String title;
  final String bannerImage;
  final List<FeedSection> sections;

  Feed({
    required this.title,
    required this.bannerImage,
    required this.sections,
  });
}

class FeedSection {
  final String title;
  final String subtitle;
  final List<FeedItem> items;

  FeedSection({
    required this.title,
    required this.subtitle,
    required this.items,
  });
}

/// Unified item for both "Sale" and "New"
class FeedItem {
  final int id;
  final String brand;
  final String name;
  final String image;

  final double? oldPrice; // sale only
  final double price;
  final int? discount; // sale only (e.g. 20)
  final bool isNew; // new items

  final double rating;
  final int reviews;
  final bool isFavorite;

  FeedItem({
    required this.id,
    required this.brand,
    required this.name,
    required this.image,
    this.oldPrice,
    required this.price,
    this.discount,
    this.isNew = false,
    required this.rating,
    required this.reviews,
    required this.isFavorite,
  });
}