import 'product_details.dart';
import 'related_product.dart';

class DetailsPageData {
  final ProductDetails product;
  final List<RelatedProduct> related;

  DetailsPageData({required this.product, required this.related});

  factory DetailsPageData.fromMap(Map<String, dynamic> m) => DetailsPageData(
    product: ProductDetails.fromMap(m),
    related: (m['relatedProducts'] as List? ?? []).map((e) => RelatedProduct.fromMap(e)).toList(),
  );
}
