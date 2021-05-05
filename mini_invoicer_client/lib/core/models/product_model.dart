class Product {
  String id;
  String name;
  String description;
  int weight;
  bool refrigerated;
  String brandId;
  String vendorId;

  Product({
    this.id,
    this.name,
    this.description,
    this.weight,
    this.refrigerated,
    this.brandId,
    this.vendorId,
  });

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String,
      weight: json['weight'] as int,
      refrigerated: json['refrigerated'] as bool,
      brandId: json['brandId'] as String,
      vendorId: json['vendorId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'weight': this.weight,
        'refrigerated': this.refrigerated,
        'brandId': this.brandId,
        'vendorId': this.vendorId,
      };
}
