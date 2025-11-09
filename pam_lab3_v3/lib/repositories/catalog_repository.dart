import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/catalog.dart';

class CatalogRepository {
  final String path;
  CatalogRepository(this.path);

  Future<Catalog> load() async {
    final jsonStr = await rootBundle.loadString(path);
    final data = json.decode(jsonStr);
    return Catalog.fromMap(data);
  }
}
