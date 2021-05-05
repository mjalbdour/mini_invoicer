class Brand {
  String id;
  String name;
  String description;
  String country;

  Brand({
    this.id,
    this.name,
    this.description,
    this.country,
  });

  factory Brand.fromJson(String id, Map<String, dynamic> json) => Brand(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        country: json['country'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'country': this.country,
      };
}
