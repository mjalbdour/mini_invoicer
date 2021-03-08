class ProductTransferType {
  String id;
  String name;
  String description;

  ProductTransferType({
    this.id,
    this.name,
    this.description,
  });

  factory ProductTransferType.fromJson(String id, Map<String, dynamic> json) =>
      ProductTransferType(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
      );

  static Map<String, dynamic> toJson(ProductTransferType productTransferType) => {
        'name': productTransferType.name,
        'description': productTransferType.description,
      };

  static Map<String, dynamic> toJsonWithId(ProductTransferType productTransferType) => {
        'id': productTransferType.id,
        'name': productTransferType.name,
        'description': productTransferType.description,
      };
}
