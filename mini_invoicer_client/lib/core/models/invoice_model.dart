class Invoice {
  String id;
  double value;
  String serialNumber;
  bool aborted;
  int printQuantity;
  DateTime timestamp;
  String vendorId;
  String employeeId;
  String customerId;
  String currencyId;
  String paymentTypeId;
  String successorInvoiceId;

  Invoice({
    this.id,
    this.value,
    this.serialNumber,
    this.aborted,
    this.printQuantity,
    this.timestamp,
    this.vendorId,
    this.employeeId,
    this.customerId,
    this.currencyId,
    this.paymentTypeId,
    this.successorInvoiceId,
  });

  factory Invoice.fromJson(String id, Map<String, dynamic> json) => Invoice(
        id: id,
        value: json['value'] as double,
        aborted: json['aborted'] as bool,
        printQuantity: json['printQuantity'] as int,
        timestamp: json['timestamp'].toDate() as DateTime,
        vendorId: json['vendorId'] as String,
        employeeId: json['employeeId'] as String,
        currencyId: json['currencyId'] as String,
        paymentTypeId: json['paymentTypeId'] as String,
        successorInvoiceId: json['successorInvoiceId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'value': this.value,
        'serialNumber': this.serialNumber,
        'aborted': this.aborted,
        'printQuantity': this.printQuantity,
        'timestamp': this.timestamp,
        'vendorId': this.vendorId,
        'employeeId': this.employeeId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
        'successorInvoiceId': this.successorInvoiceId,
      };
}
