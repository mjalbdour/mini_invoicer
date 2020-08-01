import 'package:mini_invoicer_app/models/product_model.dart';

class Invoice {
  String id;
  int number;
  DateTime date;
  List<Product> selectedProducts;
  bool edited;
  int printCount;
  double discount;
  double totalValue;

  Invoice({
    this.date,
    this.number,
    this.selectedProducts,
    this.edited,
    this.printCount,
    this.discount,
    this.totalValue,
  });

  Invoice.withId({
    this.id,
    this.number,
    this.date,
    this.selectedProducts,
    this.edited,
    this.printCount,
    this.discount,
    this.totalValue,
  });

  factory Invoice.fromMap(Map<String, dynamic> map, String id) {
    return Invoice.withId(
        id: id,
        number: map["number"],
        date: DateTime.fromMillisecondsSinceEpoch(map["date"].seconds * 1000),
        selectedProducts: map["selectedProducts"],
        edited: map["edited"],
        printCount: map["printCount"],
        discount: map["discount"],
        totalValue: map["totalValue"]);
  }

  static Map<String, dynamic> toMap(Invoice invoice) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["number"] = invoice.number;
    map["date"] = invoice.date;
    map["selectedProducts"] = invoice.selectedProducts;
    map["edited"] = invoice.edited;
    map["printCount"] = invoice.printCount;
    map["discount"] = invoice.discount;
    map["totalValue"] = invoice.totalValue;
    return map;
  }
}
