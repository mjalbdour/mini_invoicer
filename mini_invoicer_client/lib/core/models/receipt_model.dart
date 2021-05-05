class Receipt {
  String id;
  double value;
  DateTime timestamp;
  String serialNumber;
  bool aborted;
  int printQuantity;
  String invoiceId;
  String currencyId;
  String paymentTypeId;

  Receipt({
    this.id,
    this.value,
    this.timestamp,
    this.serialNumber,
    this.aborted,
    this.printQuantity,
    this.invoiceId,
    this.currencyId,
    this.paymentTypeId,
  });

  factory Receipt.fromJson(String id, Map<String, dynamic> json) => Receipt(
        id: id,
        value: json['value'] as double,
        timestamp: json['timestamp'].toDate() as DateTime,
        serialNumber: json['serialNumber'] as String,
        aborted: json['aborted'] as bool,
        printQuantity: json['printQuantity'] as int,
        invoiceId: json['invoiceId'] as String,
        currencyId: json['currencyId'] as String,
        paymentTypeId: json['paymentTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'value': this.value,
        'timestamp': this.timestamp,
        'serialNumber': this.serialNumber,
        'aborted': this.aborted,
        'printQuantity': this.printQuantity,
        'invoiceId': this.invoiceId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
      };
}
