class ProductTransferAccount {
  final String id;
  final String ownerId;
  final int totalTransfersAllTime;
  final DateTime lastUpdated;

  const ProductTransferAccount({
    this.id,
    this.ownerId,
    this.totalTransfersAllTime,
    this.lastUpdated,
  });

  factory ProductTransferAccount.fromJson(
          String id, Map<String, dynamic> json) =>
      ProductTransferAccount(
        id: id,
        ownerId: json['ownerId'] as String,
        totalTransfersAllTime: json['totalTransfers'] as int,
        lastUpdated: json['lastUpdated'].toDate() as DateTime,
      );

  Map<String, dynamic> toJson() => {
        'ownerId': this.ownerId,
        'totalTransfersAllTime': this.totalTransfersAllTime,
        'lastUpdated': this.lastUpdated,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'ownerId': this.ownerId,
        'totalTransfersAllTime': this.totalTransfersAllTime,
        'lastUpdated': this.lastUpdated,
      };
}
