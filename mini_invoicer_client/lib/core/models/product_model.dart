class Product {
  String id;
  String title;
  String description;
  int weight;
  bool refrigerated;
  String brandId;

  Product({
    this.id,
    this.title,
    this.description,
    this.weight,
    this.refrigerated,
    this.brandId,
  });

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      title: json['title'] as String,
      description: json['description'] as String,
      weight: json['weight'] as int,
      refrigerated: json['refrigerated'] as bool,
      brandId: json['brandId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'weight': this.weight,
        'refrigerated': this.refrigerated,
        'brandId': this.brandId,
      };
}
