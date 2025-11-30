import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_details_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Product> getProductDetails({String? productId}) async {
    final model = await remoteDataSource.getProductDetails(productId: productId);
    return model.toEntity();
  }
}