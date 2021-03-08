class ProductPricing {
  String id;
  double value;
  int salesTax;
  String description;
  String productId;
  String pricingId;
  String currencyId;

  ProductPricing({
    this.id,
    this.value,
    this.salesTax,
    this.description,
    this.productId,
    this.pricingId,
    this.currencyId,
  });

  factory ProductPricing.fromJson(String id, Map<String, dynamic> json) =>
      ProductPricing(
        id: id,
        value: json['value'] as double,
        salesTax: json['salesTax'] as int,
        description: json['description'] as String,
        productId: json['productId'] as String,
        pricingId: json['pricingId'] as String,
        currencyId: json['currencyId'] as String,
      );

  static Map<String, dynamic> toJson(ProductPricing productPricing) => {
        'value': productPricing.value,
        'salesTax': productPricing.salesTax,
        'description': productPricing.description,
        'productId': productPricing.productId,
        'pricingId': productPricing.pricingId,
        'currencyId': productPricing.currencyId,
      };

  static Map<String, dynamic> toJsonWithId(ProductPricing productPricing) => {
        'id': productPricing.id,
        'value': productPricing.value,
        'salesTax': productPricing.salesTax,
        'description': productPricing.description,
        'productId': productPricing.productId,
        'pricingId': productPricing.pricingId,
        'currencyId': productPricing.currencyId,
      };
}
