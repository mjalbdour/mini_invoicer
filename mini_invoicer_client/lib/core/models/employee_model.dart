import 'dart:collection';

class Employee {
  String id;
  String uid;
  LinkedHashMap<String, dynamic> name;
  String employeeTypeId;
  String accountId;
  String vendorId;
  String inventoryId;
  String addressId;

  Employee({
    this.id,
    this.uid,
    this.name,
    this.employeeTypeId,
    this.accountId,
    this.vendorId,
    this.inventoryId,
    this.addressId,
  });

  factory Employee.fromJson(String id, Map<String, dynamic> json) => Employee(
        id: id,
        uid: json['uid'] as String,
        name: json['name'] as LinkedHashMap<String, dynamic>,
        employeeTypeId: json['employeeTypeId'] as String,
        accountId: json['accountId'] as String,
        vendorId: json['vendorId'] as String,
        inventoryId: json['inventoryId'] as String,
        addressId: json['addressId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'name': this.name,
        'employeeTypeId': this.employeeTypeId,
        'accountId': this.accountId,
        'vendorId': this.vendorId,
        'inventoryId': this.inventoryId,
        'addressId': this.addressId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'uid': this.uid,
        'name': this.name,
        'employeeTypeId': this.employeeTypeId,
        'accountId': this.accountId,
        'vendorId': this.vendorId,
        'inventoryId': this.inventoryId,
        'addressId': this.addressId,
      };
}
