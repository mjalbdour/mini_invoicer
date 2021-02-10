class Customer {
  String id;
  String name;
  Map<String, dynamic> address;

  Customer({this.name, this.address});

  Customer.withId({
    this.id,
    this.name,
    this.address,
  });

  factory Customer.fromMap(Map<String, dynamic> map, String id) {
    return Customer.withId(
      id: id,
      name: map["name"],
      address: map["address"],
    );
  }

  static Map<String, dynamic> toMap(Customer customer) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["name"] = customer.name;
    map["address"] = customer.address;
    return map;
  }
}
