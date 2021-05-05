class ProductTransferType {
  String id;
  String title;
  String description;

  ProductTransferType({
    this.id,
    this.title,
    this.description,
  });

  factory ProductTransferType.fromJson(String id, Map<String, dynamic> json) =>
      ProductTransferType(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
      };
}
