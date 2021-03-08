class Invoice {
  final String id;
  final double value;
  final Map<String, dynamic> serialNumber;
  final DateTime timestamp;
  final String vendorId;
  final String employeeId;
  final String customerId;
  final String currencyId;
  final String paymentTypeId;

  const Invoice({
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

  Map<String, dynamic> toJson() => {
        'value': this.value,
        'serialNumber': this.serialNumber,
        'timestamp': this.timestamp,
        'vendorId': this.vendorId,
        'employeeId': this.employeeId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'value': this.value,
        'serialNumber': this.serialNumber,
        'timestamp': this.timestamp,
        'vendorId': this.vendorId,
        'employeeId': this.employeeId,
        'currencyId': this.currencyId,
        'paymentTypeId': this.paymentTypeId,
      };
}
