class InventoryType {
  String id;
  String name;
  String description;
  bool refrigerated;

  InventoryType({this.id, this.name, this.description, this.refrigerated});

  factory InventoryType.fromJson(String id, Map<String, dynamic> json) =>
      InventoryType(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        refrigerated: json['refrigerated'] as bool,
      );

  static Map<String, dynamic> toJson(InventoryType inventoryType) => {
        'name': inventoryType.name,
        'description': inventoryType.description,
        'refrigerated': inventoryType.refrigerated,
      };

  static Map<String, dynamic> toJsonWithId(InventoryType inventoryType) => {
        'id': inventoryType.id,
        'name': inventoryType.name,
        'description': inventoryType.description,
        'refrigerated': inventoryType.refrigerated,
      };
}
