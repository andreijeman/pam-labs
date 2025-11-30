import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/feed_models.dart';

abstract class FeedRemoteDataSource {
  Future<FeedModel> getFeed();
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  FeedRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://test-api-jlbn.onrender.com',
  });

  @override
  Future<FeedModel> getFeed() async {
    final uri = Uri.parse('$baseUrl/v3/feed');
    final response = await client.get(uri);
    print('STATUS: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return FeedModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load feed: ${response.statusCode}');
    }
  }
}