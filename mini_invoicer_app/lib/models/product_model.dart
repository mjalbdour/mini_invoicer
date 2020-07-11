class Product {
  int id;

  String name; // in english
//  String originalName; spanish/italian etc...
  String brand;
  String category;
  String ingredients;
  String packagingMaterial;
  String notes;

  // Photos -> coming soon... data type = List<String> ?...

  int packageUnits; // could be null
  int boxUnits;

  // in grams, if weight => 999g then converted to kg on the UI
  int unitWeight;
  int packageWeight; // could be null
  int boxWeight;

  int boxQuantity; // inventory purposes

//  IN Jordan Dinar
  double boxPriceCashVan;
  double boxPriceCredit;
  double boxPriceWholesale;

  double suggestedUnitShelfPrice;

  double tax;

}