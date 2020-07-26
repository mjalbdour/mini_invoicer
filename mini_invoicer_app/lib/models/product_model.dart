class Product {
  String id;
  String name;
  String originalName;
  String brand;
  String category;
  String ingredients;
  String packagingMaterial;
  String notes;

  List<String> photos;

  int packageUnits; // could be null
  int boxUnits;

  // in grams, if weight => 999g then converted to kg on the UI
  int unitWeight;
  int packageWeight; // could be null
  int boxWeight;

  int boxQuantity; // inventory purposes

  // Jordan Dinar
  // price class ? make app more generic
  double boxPriceCashVan;
  double boxPriceCredit;
  double boxPriceWholesale;

  //double suggestedUnitPrice;
  //double suggestedPackagePrice;
  //double suggestedBoxPrice;

  // tax class ?
  double tax;

  double discount;

  Product({
    this.id,
    this.name,
    this.originalName,
    this.brand,
    this.category,
    this.ingredients,
    this.packagingMaterial,
    this.photos,
    this.notes,
    this.packageUnits,
    this.boxUnits,
    this.boxQuantity,
    this.unitWeight,
    this.packageWeight,
    this.boxWeight,
    this.boxPriceCashVan,
    this.boxPriceCredit,
    this.boxPriceWholesale,
    this.tax,
    this.discount,
  });
}
