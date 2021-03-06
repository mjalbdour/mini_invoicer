class InventoryType {
  final String id;
  final String name;
  final String description;
  final bool refrigerated;

  const InventoryType(
      {this.id, this.name, this.description, this.refrigerated});

  factory InventoryType.fromJson(String id, Map<String, dynamic> json) =>
      InventoryType(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        refrigerated: json['refrigerated'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'refrigerated': this.refrigerated,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
        'refrigerated': this.refrigerated,
      };
}
