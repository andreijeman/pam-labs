import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/details_page_data.dart';

class DetailsRepository {
  final String path;
  DetailsRepository(this.path);

  Future<DetailsPageData> load() async {
    final jsonStr = await rootBundle.loadString(path);
    final data = json.decode(jsonStr);
    return DetailsPageData.fromMap(data);
  }
}
