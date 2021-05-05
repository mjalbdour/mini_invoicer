class InvoiceItem {
  String id;
  int quantity;
  int discount;
  int salesTax;
  double totalValue;
  String invoiceId;
  String productId;
  String productPricingId;

  InvoiceItem({
    this.id,
    this.quantity,
    this.discount,
    this.salesTax,
    this.totalValue,
    this.invoiceId,
    this.productId,
    this.productPricingId,
  });

  factory InvoiceItem.fromJson(String id, Map<String, dynamic> json) =>
      InvoiceItem(
        id: id,
        quantity: json['quantity'] as int,
        discount: json['discount'] as int,
        salesTax: json['salesTax'] as int,
        totalValue: json['totalValue'] as double,
        invoiceId: json['invoiceId'] as String,
        productId: json['productId'] as String,
        productPricingId: json['productPricingId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'quantity': this.quantity,
        'discount': this.discount,
        'salesTax': this.salesTax,
        'totalValue': this.totalValue,
        'invoiceId': this.invoiceId,
        'productId': this.productId,
        'productPricingId': this.productPricingId,
      };
}
