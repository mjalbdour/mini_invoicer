class Product {
  String id;
  String name;
  String description;
  int weight;
  bool requiresRefrigeration;
  String brandId;
  String vendorId;

  Product(
      {this.id,
      this.name,
      this.description,
      this.weight,
      this.requiresRefrigeration,
      this.brandId,
      this.vendorId});

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String,
      weight: json['weight'] as int,
      requiresRefrigeration: json['requiresRefrigeration'] as bool,
      brandId: json['brandId'] as String,
      vendorId: json['vendorId'] as String,
    );
  }

  static Map<String, dynamic> toJson(Product product) => {
        'name': product.name,
        'description': product.description,
        'weight': product.weight,
        'requiresRefrigeration': product.requiresRefrigeration,
        'brandId': product.brandId,
        'vendorId': product.vendorId,
      };
  static Map<String, dynamic> toJsonWithId(Product product) => {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'weight': product.weight,
        'requiresRefrigeration': product.requiresRefrigeration,
        'brandId': product.brandId,
        'vendorId': product.vendorId,
      };
}
