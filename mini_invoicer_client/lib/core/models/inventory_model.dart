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

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'lastUpdated': this.lastUpdated,
        'ownerId': this.ownerId,
        'inventoryTypeId': this.inventoryTypeId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'lastUpdated': this.lastUpdated,
        'ownerId': this.ownerId,
        'inventoryTypeId': this.inventoryTypeId,
      };
}
