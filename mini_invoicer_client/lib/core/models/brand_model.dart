class Brand {
  String id;
  String title;
  String description;
  String country;

  Brand({
    this.id,
    this.title,
    this.description,
    this.country,
  });

  factory Brand.fromJson(String id, Map<String, dynamic> json) => Brand(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
        country: json['country'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'country': this.country,
      };
}
