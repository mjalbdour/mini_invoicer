class ProductQuantity {
  String id;
  int quantity;
  String productId;
  String inventoryId;

  ProductQuantity({
    this.id,
    this.quantity,
    this.productId,
    this.inventoryId,
  });

  factory ProductQuantity.fromJson(String id, Map<String, dynamic> json) =>
      ProductQuantity(
        id: id,
        quantity: json['quantity'] as int,
        productId: json['productId'] as String,
        inventoryId: json['inventoryId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'quantity': this.quantity,
        'productId': this.productId,
        'inventoryId': this.inventoryId,
      };
}
