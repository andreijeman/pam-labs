import 'header.dart';
import 'section.dart';

class Catalog {
  final Header header;
  final List<Section> sections;
  Catalog({required this.header, required this.sections});

  factory Catalog.fromMap(Map<String, dynamic> m) => Catalog(
    header: Header.fromMap(m['header'] ?? const {}),
    sections: (m['sections'] as List? ?? []).map((e) => Section.fromMap(e)).toList(),
  );
}
