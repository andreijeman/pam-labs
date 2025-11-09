class DetailsColor {
  final String name;
  final String hex;
  final List<String> images;
  DetailsColor({required this.name, required this.hex, required this.images});

  factory DetailsColor.fromMap(Map<String, dynamic> m) => DetailsColor(
    name: m['name'] ?? '',
    hex: m['hex'] ?? '',
    images: (m['images'] as List? ?? []).map((e) => e.toString()).toList(),
  );
}
