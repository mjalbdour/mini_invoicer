class Invoice {
  String id;
  double value;
  Map<String, dynamic> serialNumber;
  DateTime timestamp;
  String vendorId;
  String employeeId;
  String customerId;
  String currencyId;
  String paymentTypeId;

  Invoice({
    this.id,
    this.value,
    this.serialNumber,
    this.timestamp,
    this.vendorId,
    this.employeeId,
    this.customerId,
    this.currencyId,
    this.paymentTypeId,
  });

  factory Invoice.fromJson(String id, Map<String, dynamic> json) => Invoice(
        id: id,
        value: json['value'] as double,
        serialNumber: json['serialNumber'] as Map<String, dynamic>,
        timestamp: json['timestamp'].toDate() as DateTime,
        vendorId: json['vendorId'] as String,
        employeeId: json['employeeId'] as String,
        currencyId: json['currencyId'] as String,
        paymentTypeId: json['paymentTypeId'] as String,
      );

  static Map<String, dynamic> toJson(Invoice invoice) => {
        'value': invoice.value,
        'serialNumber': invoice.serialNumber,
        'timestamp': invoice.timestamp,
        'vendorId': invoice.vendorId,
        'employeeId': invoice.employeeId,
        'currencyId': invoice.currencyId,
        'paymentTypeId': invoice.paymentTypeId,
      };

  static Map<String, dynamic> toJsonWithId(Invoice invoice) => {
        'id': invoice.id,
        'value': invoice.value,
        'serialNumber': invoice.serialNumber,
        'timestamp': invoice.timestamp,
        'vendorId': invoice.vendorId,
        'employeeId': invoice.employeeId,
        'currencyId': invoice.currencyId,
        'paymentTypeId': invoice.paymentTypeId,
      };
}
