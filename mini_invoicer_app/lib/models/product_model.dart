class Product {
  String _id;
  String name;
  String originalName;
  String brand;
  String category;
  String ingredients;
  String packagingMaterial;
  String notes;

  // Photos -> coming soon... data type = List<String> ?...
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

}