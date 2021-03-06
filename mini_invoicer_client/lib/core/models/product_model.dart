class Product {
  final String id;
  final String name;
  final String description;
  final int weight;

  final String brandId;
  final String vendorId;

  const Product(
      {this.id,
      this.name,
      this.description,
      this.weight,
      this.brandId,
      this.vendorId});

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String,
      weight: json['weight'] as int,
      brandId: json['brandId'] as String,
      vendorId: json['vendorId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'weight': this.weight,
        'brandId': this.brandId,
        'vendorId': this.vendorId,
      };
  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
        'weight': this.weight,
        'brandId': this.brandId,
        'vendorId': this.vendorId,
      };
}
