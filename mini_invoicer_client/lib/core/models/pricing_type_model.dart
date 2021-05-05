class PricingType {
  String id;
  String title;
  String description;

  PricingType({
    this.id,
    this.title,
    this.description,
  });

  factory PricingType.fromJson(String id, Map<String, dynamic> json) =>
      PricingType(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
      };
}
