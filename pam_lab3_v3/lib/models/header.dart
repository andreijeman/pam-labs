class Header {
  final String title;
  final String bannerImage;
  Header({required this.title, required this.bannerImage});

  factory Header.fromMap(Map<String, dynamic> map) =>
      Header(title: map['title'] ?? '', bannerImage: map['bannerImage'] ?? '');
}
