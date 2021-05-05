class InventoryType {
  String id;
  String title;
  String description;
  bool refrigerated;

  InventoryType({
    this.id,
    this.title,
    this.description,
    this.refrigerated,
  });

  factory InventoryType.fromJson(String id, Map<String, dynamic> json) =>
      InventoryType(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
        refrigerated: json['refrigerated'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'refrigerated': this.refrigerated,
      };
}
