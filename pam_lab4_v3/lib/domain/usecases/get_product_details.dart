import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetails {
  final ProductRepository repository;

  GetProductDetails(this.repository);

  Future<Product> call({String? productId}) {
    return repository.getProductDetails(productId: productId);
  }
}