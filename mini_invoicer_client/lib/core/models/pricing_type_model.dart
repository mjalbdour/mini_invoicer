class PricingType {
  String id;
  String name;
  String description;

  PricingType({
    this.id,
    this.name,
    this.description,
  });

  factory PricingType.fromJson(String id, Map<String, dynamic> json) =>
      PricingType(
          id: id,
          name: json['name'] as String,
          description: json['description'] as String);

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
      };
}
