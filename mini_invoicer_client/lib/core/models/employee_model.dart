class Employee {
  String id;
  String uid;
  Map<String, String> name;
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
        name: json['name'] as Map<String, String>,
        employeeTypeId: json['employeeTypeId'] as String,
        accountId: json['accountId'] as String,
        vendorId: json['vendorId'] as String,
        inventoryId: json['inventoryId'] as String,
        addressId: json['addressId'] as String,
      );

  static Map<String, dynamic> toJson(Employee employee) => {
        'uid': employee.uid,
        'name': employee.name,
        'employeeTypeId': employee.employeeTypeId,
        'accountId': employee.accountId,
        'vendorId': employee.vendorId,
        'inventoryId': employee.inventoryId,
        'addressId': employee.addressId,
      };

  static Map<String, dynamic> toJsonWithId(Employee employee) => {
        'id': employee.id,
        'uid': employee.uid,
        'name': employee.name,
        'employeeTypeId': employee.employeeTypeId,
        'accountId': employee.accountId,
        'vendorId': employee.vendorId,
        'inventoryId': employee.inventoryId,
        'addressId': employee.addressId,
      };
}
