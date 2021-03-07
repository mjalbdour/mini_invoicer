class Employee {
  final String id;
  final String uid;
  final Map<String, String> name;
  final String accountId;
  final String vendorId;
  final String inventoryId;
  final String addressId;

  const Employee({
    this.id,
    this.uid,
    this.name,
    this.accountId,
    this.vendorId,
    this.inventoryId,
    this.addressId,
  });

  factory Employee.fromJson(String id, Map<String, dynamic> json) => Employee(
        id: id,
        uid: json['uid'] as String,
        name: json['name'] as Map<String, String>,
        accountId: json['accountId'] as String,
        vendorId: json['vendorId'] as String,
        inventoryId: json['inventoryId'] as String,
        addressId: json['addressId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'name': this.name,
        'accountId': this.accountId,
        'vendorId': this.vendorId,
        'inventoryId': this.inventoryId,
        'addressId': this.addressId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'uid': this.uid,
        'name': this.name,
        'accountId': this.accountId,
        'vendorId': this.vendorId,
        'inventoryId': this.inventoryId,
        'addressId': this.addressId,
      };
}
