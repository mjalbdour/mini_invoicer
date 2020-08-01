class Invoice {
  String id;
  DateTime date;
  Map<String, dynamic> selectedProducts;
  bool edited;
  int printCount;
  double discount;
  double totalValue;

  Invoice({
    this.date,
    this.selectedProducts,
    this.edited,
    this.printCount,
    this.discount,
    this.totalValue,
  });

  Invoice.withId({
    this.id,
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
        date: DateTime.fromMillisecondsSinceEpoch(map["date"].seconds * 1000),
        selectedProducts: map["selectedProducts"],
        edited: map["edited"],
        printCount: map["printCount"],
        discount: map["discount"],
        totalValue: map["totalValue"]);
  }

  static Map<String, dynamic> toMap(Invoice invoice) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["date"] = invoice.date;
    map["selectedProducts"] = invoice.selectedProducts;
    map["edited"] = invoice.edited;
    map["printCount"] = invoice.printCount;
    map["discount"] = invoice.discount;
    map["totalValue"] = invoice.totalValue;
    return map;
  }
}
