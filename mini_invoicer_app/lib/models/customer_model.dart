class Customer {
  String id;
  String name;
  Map<String, dynamic> address;
  String type;
  // List<Order> orders;
  // List<String> photos;

  Customer({this.name, this.address, this.type});

  Customer.withId({
    this.id,
    this.name,
    this.address,
    this.type,
  });

  factory Customer.fromMap(Map<String, dynamic> map, String id) {
    return Customer.withId(
      id: id,
      name: map["name"],
      address: map["address"],
      type: map["type"],
    );
  }

  static Map<String, dynamic> toMap(Customer customer) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["name"] = customer.name;
    map["address"] = customer.address;
    map["type"] = customer.type;
    return map;
  }
}
