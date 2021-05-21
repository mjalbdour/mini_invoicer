class Address {
  String id;
  String street;
  String building;
  String area;
  String city;
  String country;
  String postalCode;
  // List<String> tags;

  Address({
    this.id,
    this.street,
    this.building,
    this.area,
    this.city,
    this.country,
    this.postalCode,
    // this.tags,
  });

  factory Address.fromJson(String id, Map<String, dynamic> json) => Address(
        id: id,
        street: json['street'] as String,
        building: json['building'] as String,
        area: json['area'] as String,
        city: json['city'] as String,
        country: json['country'] as String,
        postalCode: json['postalCode'] as String,
        // tags: json['tags'] as List<String>,
      );

  Map<String, dynamic> toJson() => {
        'street': this.street,
        'building': this.building,
        'area': this.area,
        'city': this.city,
        'country': this.country,
        'postalCode': this.postalCode,
        // 'tags': this.tags,
      };
}
