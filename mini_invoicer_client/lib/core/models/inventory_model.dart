class Inventory {
  String id;
  String name;
  String ownerId;
  DateTime lastUpdated;
  String inventoryTypeId;

  Inventory({
    this.id,
    this.name,
    this.lastUpdated,
    this.ownerId,
    this.inventoryTypeId,
  });

  factory Inventory.fromJson(String id, Map<String, dynamic> json) => Inventory(
        id: id,
        name: json['name'] as String,
        lastUpdated: json['lastUpdated'].toDate() as DateTime,
        ownerId: json['ownerId'] as String,
        inventoryTypeId: json['inventoryTypeId'] as String,
      );

  static Map<String, dynamic> toJson(Inventory inventory) => {
        'name': inventory.name,
        'lastUpdated': inventory.lastUpdated,
        'ownerId': inventory.ownerId,
        'inventoryTypeId': inventory.inventoryTypeId,
      };

  static Map<String, dynamic> toJsonWithId(Inventory inventory) => {
        'id': inventory.id,
        'name': inventory.name,
        'lastUpdated': inventory.lastUpdated,
        'ownerId': inventory.ownerId,
        'inventoryTypeId': inventory.inventoryTypeId,
      };
}
