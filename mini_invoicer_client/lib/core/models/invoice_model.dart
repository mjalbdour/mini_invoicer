class Invoice {
  String id;
  double value;
  Map<String, dynamic> serialNumber;
  bool aborted;
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
        serialNumber: json['serialNumber'] as Map<String, dynamic>,
        aborted: json['aborted'] as bool,
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
        'timestamp': this.timestamp,
        'vendorId': this.vendorId,
        'employeeId': this.employeeId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
        'successorInvoiceId': this.successorInvoiceId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'value': this.value,
        'serialNumber': this.serialNumber,
        'aborted': this.aborted,
        'timestamp': this.timestamp,
        'vendorId': this.vendorId,
        'employeeId': this.employeeId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
        'successorInvoiceId': this.successorInvoiceId,
      };
}
