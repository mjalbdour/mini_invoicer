class Brand {
  String id;
  String name;
  String description;
  String country;

  Brand({this.id, this.name, this.description, this.country});

  factory Brand.fromJson(String id, Map<String, dynamic> json) => Brand(
        id: id,
        name: json['name'] as String,
        description: ['description'] as String,
        country: ['country'] as String,
      );

  static Map<String, dynamic> toJson(Brand brand) => {
        'name': brand.name,
        'description': brand.description,
        'country': brand.country,
      };

  static Map<String, dynamic> toJsonWithId(Brand brand) => {
        'id': brand.id,
        'name': brand.name,
        'description': brand.description,
        'country': brand.country,
      };
}
