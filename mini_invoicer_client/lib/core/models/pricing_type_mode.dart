class PricingType {
  String id;
  String name;
  String description;

  PricingType({this.id, this.name, this.description});

  factory PricingType.fromJson(String id, Map<String, dynamic> json) =>
      PricingType(
          id: id,
          name: json['name'] as String,
          description: json['description'] as String);

  static Map<String, dynamic> toJson(PricingType pricingType) => {
        'name': pricingType.name,
        'description': pricingType.description,
      };

  static Map<String, dynamic> toJsonWithId(PricingType pricingType) => {
        'id': pricingType.id,
        'name': pricingType.name,
        'description': pricingType.description,
      };
}
