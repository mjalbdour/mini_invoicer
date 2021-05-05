class Inventory {
  String id;
  String title;
  String ownerId;
  DateTime lastUpdated;
  String inventoryTypeId;

  Inventory({
    this.id,
    this.title,
    this.lastUpdated,
    this.ownerId,
    this.inventoryTypeId,
  });

  factory Inventory.fromJson(String id, Map<String, dynamic> json) => Inventory(
        id: id,
        title: json['title'] as String,
        lastUpdated: json['lastUpdated'].toDate() as DateTime,
        ownerId: json['ownerId'] as String,
        inventoryTypeId: json['inventoryTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'lastUpdated': this.lastUpdated,
        'ownerId': this.ownerId,
        'inventoryTypeId': this.inventoryTypeId,
      };
}
