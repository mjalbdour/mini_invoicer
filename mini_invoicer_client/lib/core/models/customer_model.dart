class Customer {
  final String id;
  final String name;
  final String description;
  final String addressId;
  final String accountId;
  final String pricingTypeId;

  const Customer(
      {this.id,
      this.name,
      this.description,
      this.addressId,
      this.accountId,
      this.pricingTypeId});

  factory Customer.fromJson(String id, Map<String, dynamic> json) => Customer(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        addressId: json['addressId'] as String,
        accountId: json['accountId'] as String,
        pricingTypeId: json['pricingTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'addressId': this.addressId,
        'accountId': this.accountId,
        'pricingTypeId': this.pricingTypeId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
        'addressId': this.addressId,
        'accountId': this.accountId,
        'pricingTypeId': this.pricingTypeId,
      };
}