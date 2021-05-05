class ProductPricing {
  String id;
  double price;
  int salesTax;
  String description;
  String productId;
  String pricingTypeId;
  String currencyId;

  ProductPricing({
    this.id,
    this.price,
    this.salesTax,
    this.description,
    this.productId,
    this.pricingTypeId,
    this.currencyId,
  });

  factory ProductPricing.fromJson(String id, Map<String, dynamic> json) =>
      ProductPricing(
        id: id,
        price: json['price'] as double,
        salesTax: json['salesTax'] as int,
        description: json['description'] as String,
        productId: json['productId'] as String,
        pricingTypeId: json['pricingTypeId'] as String,
        currencyId: json['currencyId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'price': this.price,
        'salesTax': this.salesTax,
        'description': this.description,
        'productId': this.productId,
        'pricingTypeId': this.pricingTypeId,
        'currencyId': this.currencyId,
      };
}
