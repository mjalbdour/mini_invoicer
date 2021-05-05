class ProductTransfer {
  String id;
  int quantity;
  String description;
  DateTime timestamp;
  String productId;
  String fromInventoryId;
  String toInventoryId;
  String productTransferTypeId;
  String sourceProductTransferId;

  ProductTransfer({
    this.id,
    this.quantity,
    this.description,
    this.timestamp,
    this.productId,
    this.fromInventoryId,
    this.toInventoryId,
    this.productTransferTypeId,
    this.sourceProductTransferId,
  });

  factory ProductTransfer.fromJson(String id, Map<String, dynamic> json) =>
      ProductTransfer(
        id: id,
        quantity: json['quantity'] as int,
        description: json['description'] as String,
        timestamp: json['timestamp'].toDate() as DateTime,
        productId: json['productId'] as String,
        fromInventoryId: json['fromInventoryId'] as String,
        toInventoryId: json['toInventoryId'] as String,
        productTransferTypeId: json['productTransferTypeId'] as String,
        sourceProductTransferId: json['sourceProductTransferId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'quantity': this.quantity,
        'description': this.description,
        'timestamp': this.timestamp,
        'productId': this.productId,
        'fromInventoryId': this.fromInventoryId,
        'toInventoryId': this.toInventoryId,
        'productTransferTypeId': this.productTransferTypeId,
        'sourceProductTransferId': this.sourceProductTransferId,
      };
}
