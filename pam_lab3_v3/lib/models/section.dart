import 'product.dart';

class Section {
  final String title;
  final String subtitle;
  final List<Product> items;

  Section({required this.title, required this.subtitle, required this.items});

  factory Section.fromMap(Map<String, dynamic> m) => Section(
    title: m['title'] ?? '',
    subtitle: m['subtitle'] ?? '',
    items: (m['items'] as List? ?? []).map((e) => Product.fromMap(e)).toList(),
  );
}
