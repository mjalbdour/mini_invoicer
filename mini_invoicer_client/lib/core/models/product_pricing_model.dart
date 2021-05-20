class ProductPricing {
  String id;
  double price;
  int salesTax;
  String productId;
  String pricingTypeId;
  String currency;

  ProductPricing({
    this.id,
    this.price,
    this.salesTax,
    this.productId,
    this.pricingTypeId,
    this.currency,
  });

  factory ProductPricing.fromJson(String id, Map<String, dynamic> json) =>
      ProductPricing(
        id: id,
        price: json['price'] as double,
        salesTax: json['salesTax'] as int,
        productId: json['productId'] as String,
        pricingTypeId: json['pricingTypeId'] as String,
        currency: json['currencyId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'price': this.price,
        'salesTax': this.salesTax,
        'productId': this.productId,
        'pricingTypeId': this.pricingTypeId,
        'currencyId': this.currency,
      };
}
