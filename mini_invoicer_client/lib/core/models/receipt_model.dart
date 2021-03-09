class Receipt {
  String id;
  double value;
  DateTime timestamp;
  Map<String, dynamic> serialNumber;
  String invoiceId;
  String currencyId;
  String paymentTypeId;

  Receipt({
    this.id,
    this.value,
    this.timestamp,
    this.serialNumber,
    this.invoiceId,
    this.currencyId,
    this.paymentTypeId,
  });

  factory Receipt.fromJson(String id, Map<String, dynamic> json) => Receipt(
        id: id,
        value: json['value'] as double,
        timestamp: json['timestamp'].toDate() as DateTime,
        serialNumber: json['serialNumber'] as Map<String, dynamic>,
        invoiceId: json['invoiceId'] as String,
        currencyId: json['currencyId'] as String,
        paymentTypeId: json['paymentTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'value': this.value,
        'timestamp': this.timestamp,
        'serialNumber': this.serialNumber,
        'invoiceId': this.invoiceId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
      };
  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'value': this.value,
        'timestamp': this.timestamp,
        'serialNumber': this.serialNumber,
        'invoiceId': this.invoiceId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
      };
}
