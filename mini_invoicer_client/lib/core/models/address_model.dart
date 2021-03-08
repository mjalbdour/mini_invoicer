class Address {
  String id;
  String street;
  String building;
  String area;
  String city;
  String country;
  String postalCode;
  String ownerId;

  Address({
    this.id,
    this.street,
    this.building,
    this.area,
    this.city,
    this.country,
    this.postalCode,
    this.ownerId,
  });

  factory Address.fromJson(String id, Map<String, dynamic> json) => Address(
        id: json['id'] as String,
        street: json['street'] as String,
        building: json['building'] as String,
        area: json['area'] as String,
        city: json['city'] as String,
        country: json['country'] as String,
        postalCode: json['postalCode'] as String,
        ownerId: json['ownerId'] as String,
      );

  static Map<String, dynamic> toJson(Address address) => {
        'street': address.street,
        'building': address.building,
        'area': address.area,
        'city': address.city,
        'country': address.country,
        'postalCode': address.postalCode,
        'ownerId': address.ownerId,
      };

  static Map<String, dynamic> toJsonWithId(Address address) => {
        'id': address.id,
        'street': address.street,
        'building': address.building,
        'area': address.area,
        'city': address.city,
        'country': address.country,
        'postalCode': address.postalCode,
        'ownerId': address.ownerId,
      };
}
