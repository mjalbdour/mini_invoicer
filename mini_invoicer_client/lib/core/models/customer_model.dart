class Customer {
  String id;
  String name;
  String description;
  String addressId;
  String accountId;
  String inventoryId;
  String pricingTypeId;

  Customer({
    this.id,
    this.name,
    this.description,
    this.addressId,
    this.accountId,
    this.inventoryId,
    this.pricingTypeId,
  });

  factory Customer.fromJson(String id, Map<String, dynamic> json) => Customer(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        addressId: json['addressId'] as String,
        accountId: json['accountId'] as String,
        inventoryId: json['inventoryId'] as String,
        pricingTypeId: json['pricingTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'addressId': this.addressId,
        'accountId': this.accountId,
        'inventoryId': this.inventoryId,
        'pricingTypeId': this.pricingTypeId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
        'addressId': this.addressId,
        'accountId': this.accountId,
        'inventoryId': this.inventoryId,
        'pricingTypeId': this.pricingTypeId,
      };
}
