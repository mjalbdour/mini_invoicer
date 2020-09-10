class Order {
  String id;
  DateTime date;
  double totalValue;

  Order({
    this.date,
    this.totalValue,
  });

  Order.withId({
    this.id,
    this.date,
    this.totalValue,
  });

  factory Order.fromMap(Map<String, dynamic> map, String id) {
    return Order.withId(
        id: id,
        date: DateTime.fromMillisecondsSinceEpoch(map["date"].seconds *
            1000), // TimeStamp map --> access seconds then to DateTime
        totalValue: map["totalValue"]);
  }

  static Map<String, dynamic> toMap(Order order) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["date"] = order.date;
    map["totalValue"] = order.totalValue;
    return map;
  }
}
