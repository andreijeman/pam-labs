import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_details_models.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails({String? productId});
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ProductDetailsRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://test-api-jlbn.onrender.com',
  });

  @override
  Future<ProductDetailsModel> getProductDetails({String? productId}) async {
    // For future: add productId as query if API supports it
    final uri = Uri.parse('$baseUrl/v3/feed/details');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return ProductDetailsModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load product details: ${response.statusCode}');
    }
  }
}