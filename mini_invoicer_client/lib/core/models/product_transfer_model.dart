class ProductTransfer {
  String id;
  int value;
  String description;
  DateTime timestamp;
  String productId;
  String sourceInventoryId;
  String destinationInventoryId;
  String productTransferTypeId;
  String sourceProductTransferId;

  ProductTransfer({
    this.id,
    this.value,
    this.description,
    this.timestamp,
    this.productId,
    this.sourceInventoryId,
    this.destinationInventoryId,
    this.productTransferTypeId,
    this.sourceProductTransferId,
  });

  factory ProductTransfer.fromJson(String id, Map<String, dynamic> json) =>
      ProductTransfer(
        id: id,
        value: json['value'] as int,
        description: json['description'] as String,
        timestamp: json['timestamp'].toDate() as DateTime,
        productId: json['productId'] as String,
        sourceInventoryId: json['sourceInventoryId'] as String,
        destinationInventoryId: json['destinationInventoryId'] as String,
        productTransferTypeId: json['productTransferTypeId'] as String,
        sourceProductTransferId: json['sourceProductTransferId'] as String,
      );

  static Map<String, dynamic> toJson(ProductTransfer productTransfer) => {
        'value': productTransfer.value,
        'description': productTransfer.description,
        'timestamp': productTransfer.timestamp,
        'productId': productTransfer.productId,
        'sourceInventoryId': productTransfer.sourceInventoryId,
        'destinationInventoryId': productTransfer.destinationInventoryId,
        'productTransferTypeId': productTransfer.productTransferTypeId,
        'sourceProductTransferId': productTransfer.sourceProductTransferId,
      };

  static Map<String, dynamic> toJsonWithId(ProductTransfer productTransfer) => {
        'id': productTransfer.id,
        'value': productTransfer.value,
        'description': productTransfer.description,
        'timestamp': productTransfer.timestamp,
        'productId': productTransfer.productId,
        'sourceInventoryId': productTransfer.sourceInventoryId,
        'destinationInventoryId': productTransfer.destinationInventoryId,
        'productTransferTypeId': productTransfer.productTransferTypeId,
        'sourceProductTransferId': productTransfer.sourceProductTransferId,
      };
}
