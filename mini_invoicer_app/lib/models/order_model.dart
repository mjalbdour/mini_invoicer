import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id;
  String customerId;
  DateTime date;
  double totalValue;

  Order({
    this.customerId,
    this.date,
    this.totalValue,
  });

  Order.withId({
    this.id,
    this.customerId,
    this.date,
    this.totalValue,
  });

  factory Order.fromMap(Map<String, dynamic> map, String id) {
    return Order.withId(
        id: id,
        customerId: map["customerId"],
        date: DateTime.fromMillisecondsSinceEpoch(map["date"].seconds *
            1000), // format then convert to date object?...
        totalValue: map["totalValue"]);
  }

  static Map<String, dynamic> toMap(Order order) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["customerId"] = order.customerId;
    map["date"] = order.date;
    map["totalValue"] = order.totalValue;
    return map;
  }
}
