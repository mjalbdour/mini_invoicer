class Inventory {
  final String id;
  final String name;
  final String vendorId;
  final String employeeId;
  final String inventoryTypeId;

  const Inventory({
    this.id,
    this.name,
    this.vendorId,
    this.employeeId,
    this.inventoryTypeId,
  });

  factory Inventory.fromJson(String id, Map<String, dynamic> json) => Inventory(
        id: id,
        name: json['name'] as String,
        vendorId: json['vendorId'] as String,
        employeeId: json['employeeId'] as String,
        inventoryTypeId: json['inventoryTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'vendorId': this.vendorId,
        'employeeId': this.employeeId,
        'inventoryTypeId': this.inventoryTypeId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'vendorId': this.vendorId,
        'employeeId': this.employeeId,
        'inventoryTypeId': this.inventoryTypeId,
      };
}
