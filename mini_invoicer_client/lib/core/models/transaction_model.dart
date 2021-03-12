class TransactionModel {
  String id;
  double value;
  DateTime timestamp;
  String senderAccountId;
  String receiverAccountId;
  String currencyId;

  TransactionModel({
    this.id,
    this.value,
    this.timestamp,
    this.senderAccountId,
    this.receiverAccountId,
    this.currencyId,
  });

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      TransactionModel(
        id: id,
        value: json['value'] as double,
        timestamp: json['timestamp'].toDate() as DateTime,
        senderAccountId: json['senderAccountId'] as String,
        receiverAccountId: json['receiverAccountId'] as String,
        currencyId: json['currencyId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'value': this.value,
        'timestamp': this.timestamp,
        'senderAccountId': this.senderAccountId,
        'receiverAccountId': this.receiverAccountId,
        'currencyId': this.currencyId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'value': this.value,
        'timestamp': this.timestamp,
        'senderAccountId': this.senderAccountId,
        'receiverAccountId': this.receiverAccountId,
        'currencyId': this.currencyId,
      };
}
