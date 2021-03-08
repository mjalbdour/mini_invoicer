class Customer {
  String id;
  String name;
  String description;
  String addressId;
  String accountId;
  String inventoryId;
  String pricingTypeId;

  Customer(
      {this.id,
      this.name,
      this.description,
      this.addressId,
      this.accountId,
      this.inventoryId,
      this.pricingTypeId});

  factory Customer.fromJson(String id, Map<String, dynamic> json) => Customer(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        addressId: json['addressId'] as String,
        accountId: json['accountId'] as String,
        inventoryId: json['inventoryId'] as String,
        pricingTypeId: json['pricingTypeId'] as String,
      );

  static Map<String, dynamic> toJson(Customer customer) => {
        'name': customer.name,
        'description': customer.description,
        'addressId': customer.addressId,
        'accountId': customer.accountId,
        'inventoryId': customer.inventoryId,
        'pricingTypeId': customer.pricingTypeId,
      };

  static Map<String, dynamic> toJsonWithId(Customer customer) => {
        'id': customer.id,
        'name': customer.name,
        'description': customer.description,
        'addressId': customer.addressId,
        'accountId': customer.accountId,
        'inventoryId': customer.inventoryId,
        'pricingTypeId': customer.pricingTypeId,
      };
}
