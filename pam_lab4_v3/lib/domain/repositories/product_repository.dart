
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Product> getProductDetails({String? productId});
}