class Brand {
  final String id;
  final String name;
  final String description;
  final String country;

  const Brand({this.id, this.name, this.description, this.country});

  factory Brand.fromJson(String id, Map<String, dynamic> json) => Brand(
        id: id,
        name: json['name'] as String,
        description: ['description'] as String,
        country: ['country'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'country': this.country,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
        'country': this.country,
      };
}
