import 'package:flutter/cupertino.dart';

class Product {
  String id;
  String name;
  String originalName;
  String brand;
  String category;
  String ingredients;
  String packagingMaterial;
  String notes;

  // List<String> photos;

  int packageQuantity; // could be null
  int unitQuantity;

  // in grams, if weight => 999g then converted to kg on the UI
  int unitWeight;
  int packageWeight; // could be null
  int boxWeight;

  int boxQuantity; // inventory purposes

  // Jordan Dinar
  // price class ? make app more generic
  double price;

  // tax class ?
  double tax;

  double discount;

  int orderAmount;

  bool selected;

  Product({
    this.name,
    this.originalName,
    this.brand,
    this.category,
    this.ingredients,
    this.packagingMaterial,
    this.notes,
    this.packageQuantity,
    this.unitQuantity,
    this.boxQuantity,
    this.unitWeight,
    this.packageWeight,
    this.boxWeight,
    this.price,
    this.tax,
    this.discount,
  });

  Product.withId({
    @required this.id,
    this.name,
    this.originalName,
    this.brand,
    this.category,
    this.ingredients,
    this.packagingMaterial,
    this.notes,
    this.packageQuantity,
    this.unitQuantity,
    this.boxQuantity,
    this.unitWeight,
    this.packageWeight,
    this.boxWeight,
    this.price,
    this.tax,
    this.discount,
  });

  Product.withSelection({
    this.id,
    this.name,
    this.originalName,
    this.brand,
    this.category,
    this.ingredients,
    this.packagingMaterial,
    this.notes,
    this.packageQuantity,
    this.unitQuantity,
    this.boxQuantity,
    this.unitWeight,
    this.packageWeight,
    this.boxWeight,
    this.tax,
    this.price,
    this.discount,
    this.orderAmount,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product.withId(
      id: id,
      name: map["name"],
      originalName: map["originalName"],
      brand: map["brand"],
      category: map["category"],
      ingredients: map["ingredients"],
      packagingMaterial: map["packagingMaterial"],
      notes: map["notes"],
      unitQuantity: map["unitQuantity"],
      packageQuantity: map["packageQuantity"],
      boxQuantity: map["boxQuantity"],
      unitWeight: map["unitWeight"],
      packageWeight: map["packageWeight"],
      boxWeight: map["boxWeight"],
      price: map["price"],
      tax: map["tax"],
      discount: map["discount"],
    );
  }

  static Map<String, dynamic> toMap(Product product) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["name"] = product.name;
    map["originalName"] = product.originalName;
    map["brand"] = product.brand;
    map["category"] = product.category;
    map["ingredients"] = product.ingredients;
    map["packagingMaterial"] = product.packagingMaterial;
    map["notes"] = product.notes;

    map["unitQuantity"] = product.unitQuantity;
    map["packageQuantity"] = product.packageQuantity;
    map["boxQuantity"] = product.boxQuantity;

    map["unitWeight"] = product.unitWeight;
    map["packageWeight"] = product.packageWeight;
    map["boxWeight"] = product.boxWeight;

    map["price"] = product.price;

    map["tax"] = product.tax;

    map["discount"] = product.discount;

    return map;
  }

  static Map<String, dynamic> toMapWithSelection(Product product) {
    Map<String, dynamic> map = <String, dynamic>{};
    map["reference"] = product.id;
    map["name"] = product.name;
    map["price"] = product.price;
    map["orderAmount"] = product.orderAmount;
    return map;
  }
}
