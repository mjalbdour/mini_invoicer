class Vendor {
  final String id;
  final String name;
  final String description;
  final String taxNumber;
  final String addressId;
  final String accountId;

  const Vendor({
    this.id,
    this.name,
    this.description,
    this.taxNumber,
    this.addressId,
    this.accountId,
  });

  factory Vendor.fromJson(String id, Map<String, dynamic> json) => Vendor(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        taxNumber: json['taxNumber'] as String,
        addressId: json['addressId'] as String,
        accountId: json['accountId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description,
        'taxNumber': this.taxNumber,
        'addressId': this.addressId,
        'accountId': this.accountId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
        'taxNumber': this.taxNumber,
        'addressId': this.addressId,
        'accountId': this.accountId,
      };
}
