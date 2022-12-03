class Language {
  final String urlIcon;
  final String title;
  Language({
    required this.urlIcon,
    required this.title,
  });

  static Language fromJson(json) => Language(
        title: json['title'],
        urlIcon: json['urlIcon'],
      );
}
