import 'package:flutter/foundation.dart';

class Company {
  String id;
  String number;
  String name;
  String description;
  Map<String, dynamic> address;

  Company({
    this.number,
    this.name,
    this.description,
    this.address,
  });

  Company._withId({
    @required this.id,
    this.number,
    this.name,
    this.description,
    this.address,
  });

  factory Company.fromMap(Map<String, dynamic> map, String id) {
    return Company._withId(
      id: id,
      number: map["number"],
      name: map["name"],
      description: map["description"],
      address: map["address"],
    );
  }

  static Map<String, dynamic> toMap(Company company) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["name"] = company.name;
    map["description"] = company.description;
    map["address"] = company.address;
    return map;
  }
}
