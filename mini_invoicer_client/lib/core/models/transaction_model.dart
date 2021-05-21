class TransactionModel {
  String id;
  double value;
  DateTime timestamp;
  String serialNumber;
  String fromAccountId;
  String toAccountId;

  // String currencyId;

  TransactionModel({
    this.id,
    this.value,
    this.timestamp,
    this.serialNumber,
    this.fromAccountId,
    this.toAccountId,
    // this.currencyId,
  });

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      TransactionModel(
        id: id,
        value: json['value'] as double,
        timestamp: json['timestamp'].toDate() as DateTime,
        serialNumber: json['serialNumber'] as String,
        fromAccountId: json['fromAccountId'] as String,
        toAccountId: json['toAccountId'] as String,
        // currencyId: json['currencyId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'value': this.value,
        'timestamp': this.timestamp,
        'serialNumber': this.serialNumber,
        'fromAccountId': this.fromAccountId,
        'toAccountId': this.toAccountId,
        // 'currencyId': this.currencyId,
      };
}
