import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_invoicer_client/core/models/account_model.dart';
import 'package:mini_invoicer_client/core/models/address_model.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/core/models/currency_model.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/core/models/image_model.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/core/models/inventory_type_model.dart';
import 'package:mini_invoicer_client/core/models/invoice_item_model.dart';
import 'package:mini_invoicer_client/core/models/invoice_model.dart';
import 'package:mini_invoicer_client/core/models/pricing_type_model.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/core/models/product_pricing_model.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_model.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_type_model.dart';
import 'package:mini_invoicer_client/core/models/receipt_model.dart';
import 'package:mini_invoicer_client/core/models/transaction_model.dart';
import 'package:mini_invoicer_client/core/models/vendor_model.dart';

class FirebaseCloudFirestoreService {
  final FirebaseFirestore _db;

  FirebaseCloudFirestoreService(this._db);

  // GENERIC QUERIES
  // SINGLE
  Stream<T> _streamSingle<T>(String id, String collectionPath,
          T fromJson(String id, Map<String, dynamic> json)) =>
      _db
          .collection(collectionPath)
          .doc(id)
          .snapshots()
          .map((snapshot) => fromJson(id, snapshot.data()));

  // MULTIPLE
  Stream<List<T>> _streamMultiple<T>(String collectionPath,
          T fromJson(String id, Map<String, dynamic> json)) =>
      _db.collection(collectionPath).snapshots().map((snapshot) => snapshot.docs
          .map(
            (doc) => fromJson(
              doc.id,
              doc.data(),
            ),
          )
          .toList());

  // GENERIC COMMANDS
  // ADD
  Future<DocumentReference> add<T>(
      String collectionPath, Map<String, dynamic> toJson()) async {
    DocumentReference docRef;
    try {
      docRef = await _db.collection(collectionPath).add(toJson());
      print("add successful");
    } catch (ex) {
      print("add unsuccessful, exception: $ex");
      throw ex;
    }
    return docRef;
  }

  // UPDATE
  Future<DocumentReference> update<T>(
      String collectionPath, String id, Map<String, dynamic> toJson()) async {
    DocumentReference docRef;
    try {
      docRef = _db.collection(collectionPath).doc(id);
      await docRef.update(toJson());
      print("update successful");
    } catch (ex) {
      print("update unsuccessful, exception: $ex");
      throw ex;
    }
    return docRef;
  }

  // DELETE
  Future<DocumentReference> delete<T>(String collectionPath, String id) async {
    DocumentReference docRef;
    try {
      docRef = _db.collection(collectionPath).doc(id);
      await docRef.delete();
      print("delete successful");
    } catch (ex) {
      print("delete unsuccessful, exception: $ex");
      throw ex;
    }
    return docRef;
  }

  // Product QUERY
  // SINGLE
  Stream<Product> streamProduct(String id) => _streamSingle<Product>(
      id, "/products", (id, json) => Product.fromJson(id, json));

  // MULTIPLE
  Stream<List<Product>> streamProducts() => _streamMultiple<Product>(
      "/products", (id, json) => Product.fromJson(id, json));

  // Product COMMAND
  // CREATE
  Future<DocumentReference> addProduct(Product product) =>
      add<Product>("/products", () => product.toJson());

  // UPDATE
  Future<DocumentReference> updateProduct(Product product) =>
      update<Product>("/products", product.id, () => product.toJson());

  // DELETE
  Future<DocumentReference> deleteProduct(String id) =>
      delete<Product>("/products", id);

  // PricingType QUERY
  // SINGLE
  Stream<PricingType> streamPricingType(String id) =>
      _streamSingle<PricingType>(
          id, "/pricingtypes", (id, json) => PricingType.fromJson(id, json));

  // MULTIPLE
  Stream<List<PricingType>> streamPricingTypes() =>
      _streamMultiple<PricingType>(
          "/pricingtypes", (id, json) => PricingType.fromJson(id, json));

  // PricingType COMMAND
  // CREATE
  Future<DocumentReference> addPricingType(PricingType pricingType) =>
      add<PricingType>("/pricingtypes", () => pricingType.toJson());

  // UPDATE
  Future<DocumentReference> updatePricingType(PricingType pricingType) =>
      update<PricingType>(
          "/pricingtypes", pricingType.id, () => pricingType.toJson());

  // DELETE
  Future<DocumentReference> deletePricingType(String id) =>
      delete<PricingType>("/pricingtypes", id);

  // ProductPricing QUERY
  // SINGLE
  Stream<ProductPricing> streamProductPricing(String id) =>
      _streamSingle<ProductPricing>(id, "productpricings",
          (id, json) => ProductPricing.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductPricing>> streamProductPricings() =>
      _streamMultiple<ProductPricing>(
          "productpricings", (id, json) => ProductPricing.fromJson(id, json));

  // ProductPricing COMMAND
  // CREATE
  Future<DocumentReference> addProductPricing(ProductPricing pricingType) =>
      add<ProductPricing>("/productpricings", () => pricingType.toJson());

  // UPDATE
  Future<DocumentReference> updateProductPricing(ProductPricing pricingType) =>
      update<ProductPricing>(
          "/productpricings", pricingType.id, () => pricingType.toJson());

  // DELETE
  Future<DocumentReference> deleteProductPricing(String id) =>
      delete<ProductPricing>("/productpricings", id);

  // Vendor QUERY
  // SINGLE
  Stream<Vendor> streamVendor(String id) => _streamSingle<Vendor>(
      id, "/vendors", (id, json) => Vendor.fromJson(id, json));

  // Vendor COMMAND
  // CREATE
  Future<DocumentReference> addVendor(Vendor vendor) =>
      add<Vendor>("/vendors", () => vendor.toJson());

  // UPDATE
  Future<DocumentReference> updateVendor(Vendor vendor) =>
      update<Vendor>("/vendors", vendor.id, () => vendor.toJson());

  // DELETE
  Future<DocumentReference> deleteVendor(String id) =>
      delete<Vendor>("/vendors", id);

  // Employee QUERY
  // SINGLE
  Stream<Employee> streamEmployee(String id) => _streamSingle<Employee>(
      id, "/employess", (id, json) => Employee.fromJson(id, json));

  // MULTIPLE
  Stream<List<Employee>> streamEmployees() => _streamMultiple<Employee>(
      "/employess", (id, json) => Employee.fromJson(id, json));

  // Employee COMMAND
  // CREATE
  Future<DocumentReference> addEmployee(Employee employee) =>
      add<Employee>("/employees", () => employee.toJson());

  // UPDATE
  Future<DocumentReference> updateEmployee(Employee employee) =>
      update<Employee>("/employees", employee.id, () => employee.toJson());

  // DELETE
  Future<DocumentReference> deleteEmployee(String id) =>
      delete<Employee>("/employees", id);

  // Brand QUERY
  // SINGLE
  Stream<Brand> streamBrand(String id) => _streamSingle<Brand>(
      id, "/brands", (id, json) => Brand.fromJson(id, json));

  // MULTIPLE
  Stream<List<Brand>> streamBrands() =>
      _streamMultiple<Brand>("/brands", (id, json) => Brand.fromJson(id, json));

  // Brand COMMAND
  // CREATE
  Future<DocumentReference> addBrand(Brand brand) =>
      add<Brand>("/brands", () => brand.toJson());

  // UPDATE
  Future<DocumentReference> updateBrand(Brand brand) =>
      update<Brand>("/brands", brand.id, () => brand.toJson());

  // DELETE
  Future<DocumentReference> deleteBrand(String id) =>
      delete<Brand>("/brands", id);

  // Customer QUERY
  // SINGLE
  Stream<Customer> streamCustomer(String id) => _streamSingle<Customer>(
      id, "/customers", (id, json) => Customer.fromJson(id, json));

  // MULTIPLE
  Stream<List<Customer>> streamCustomers() => _streamMultiple<Customer>(
      "/customers", (id, json) => Customer.fromJson(id, json));

  // Customer COMMAND
  // CREATE
  Future<DocumentReference> addCustomer(Customer customer) =>
      add<Customer>("/customers", () => customer.toJson());

  // UPDATE
  Future<DocumentReference> updateCustomer(Customer customer) =>
      update<Customer>("/customers", customer.id, () => customer.toJson());

  // DELETE
  Future<DocumentReference> deleteCustomer(String id) =>
      delete<Customer>("/customers", id);

  // ImageModel QUERY
  // SINGLE
  Stream<ImageModel> streamImageModel(String id) => _streamSingle<ImageModel>(
      id, "/images", (id, json) => ImageModel.fromJson(id, json));

  // MULTIPLE
  Stream<List<ImageModel>> streamImageModels() => _streamMultiple<ImageModel>(
      "/images", (id, json) => ImageModel.fromJson(id, json));

  // ImageModel COMMAND
  // CREATE
  Future<DocumentReference> addImageModel(ImageModel imageModel) =>
      add<ImageModel>("/imagemodels", () => imageModel.toJson());

  // UPDATE
  Future<DocumentReference> updateImageModel(ImageModel imageModel) =>
      update<ImageModel>(
          "/imagemodels", imageModel.id, () => imageModel.toJson());

  // DELETE
  Future<DocumentReference> deleteImageModel(String id) =>
      delete<ImageModel>("/imagemodels", id);

  // Inventory QUERY
  // SINGLE
  Stream<Inventory> streamInventory(String id) => _streamSingle<Inventory>(
      id, "/inventories", (id, json) => Inventory.fromJson(id, json));

  // MULTIPLE
  Stream<List<Inventory>> streamInventories() => _streamMultiple<Inventory>(
      "/inventories", (id, json) => Inventory.fromJson(id, json));

  // Inventory COMMAND
  // CREATE
  Future<DocumentReference> addInventory(Inventory inventory) =>
      add<Inventory>("/inventories", () => inventory.toJson());

  // UPDATE
  Future<DocumentReference> updateInventory(Inventory inventory) =>
      update<Inventory>("/inventories", inventory.id, () => inventory.toJson());

  // DELETE
  Future<DocumentReference> deleteInventory(String id) =>
      delete<Inventory>("/inventories", id);

  // InventoryType QUERY
  // SINGLE
  Stream<InventoryType> streamInventoryType(String id) =>
      _streamSingle<InventoryType>(id, "/inventorytypes",
          (id, json) => InventoryType.fromJson(id, json));

  // MULTIPLE
  Stream<List<InventoryType>> streamInventoryTypes() =>
      _streamMultiple<InventoryType>(
          "/inventorytypes", (id, json) => InventoryType.fromJson(id, json));

  // InventoryType COMMAND
  // CREATE
  Future<DocumentReference> addInventoryType(InventoryType inventoryType) =>
      add<InventoryType>("/inventorytypes", () => inventoryType.toJson());

  // UPDATE
  Future<DocumentReference> updateInventoryType(InventoryType inventoryType) =>
      update<InventoryType>(
          "/inventorytypes", inventoryType.id, () => inventoryType.toJson());

  // DELETE
  Future<DocumentReference> deleteInventoryType(String id) =>
      delete<InventoryType>("/inventorytypes", id);

  // ProductTransfer QUERY
  // SINGLE
  Stream<ProductTransfer> streamProductTransfer(String id) =>
      _streamSingle<ProductTransfer>(id, "/producttransfers",
          (id, json) => ProductTransfer.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductTransfer>> streamProductTransfers() =>
      _streamMultiple<ProductTransfer>("/producttransfers",
          (id, json) => ProductTransfer.fromJson(id, json));

  // ProductTransfer COMMAND
  // CREATE
  Future<DocumentReference> addProductTransfer(
          ProductTransfer productTransfer) =>
      add<ProductTransfer>("/producttransfers", () => productTransfer.toJson());

  // UPDATE
  Future<DocumentReference> updateProductTransfer(
          ProductTransfer productTransfer) =>
      update<ProductTransfer>("/producttransfers", productTransfer.id,
          () => productTransfer.toJson());

  // DELETE
  Future<DocumentReference> deleteProductTransfer(String id) =>
      delete<ProductTransfer>("/producttransfers", id);

  // ProductTransferType QUERY
  // SINGLE
  Stream<ProductTransferType> streamProductTransferType(String id) =>
      _streamSingle<ProductTransferType>(id, "/producttransfertypes",
          (id, json) => ProductTransferType.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductTransferType>> streamProductTransferTypes() =>
      _streamMultiple<ProductTransferType>("/producttransfertypes",
          (id, json) => ProductTransferType.fromJson(id, json));

  // ProductTransferType COMMAND
  // CREATE
  Future<DocumentReference> addProductTransferType(
          ProductTransferType productTransferType) =>
      add<ProductTransferType>(
          "/producttransfertypes", () => productTransferType.toJson());

  // UPDATE
  Future<DocumentReference> updateProductTransferType(
          ProductTransferType productTransferType) =>
      update<ProductTransferType>("/producttransfertypes",
          productTransferType.id, () => productTransferType.toJson());

  // DELETE
  Future<DocumentReference> deleteProductTransferType(String id) =>
      delete<ProductTransfer>("/producttransfertypes", id);

  // Invoice QUERY
  // SINGLE
  Stream<Invoice> streamInvoice(String id) => _streamSingle<Invoice>(
      id, "/invoices", (id, json) => Invoice.fromJson(id, json));

  // MULTIPLE
  Stream<List<Invoice>> streamInvoices() => _streamMultiple<Invoice>(
      "/invoices", (id, json) => Invoice.fromJson(id, json));

  // Invoice COMMAND
  // CREATE
  Future<DocumentReference> addInvoice(Invoice invoice) =>
      add<Invoice>("/invoices", () => invoice.toJson());

  // UPDATE
  Future<DocumentReference> updateInvoice(Invoice invoice) =>
      update<Invoice>("/invoices", invoice.id, () => invoice.toJson());

  // DELETE
  Future<DocumentReference> deleteInvoice(String id) =>
      delete<Invoice>("/invoices", id);

  // InvoiceItem QUERY
  // SINGLE
  Stream<InvoiceItem> streamInvoiceItem(String id) =>
      _streamSingle<InvoiceItem>(
          id, "/invoiceitems", (id, json) => InvoiceItem.fromJson(id, json));

  // MULTIPLE
  Stream<List<InvoiceItem>> streamInvoiceItems() =>
      _streamMultiple<InvoiceItem>(
          "/invoiceitems", (id, json) => InvoiceItem.fromJson(id, json));

  // InvoiceItem COMMAND
  // CREATE
  Future<DocumentReference> addInvoiceItem(InvoiceItem invoiceItem) =>
      add<InvoiceItem>("/invoiceitems", () => invoiceItem.toJson());

  // UPDATE
  Future<DocumentReference> updateInvoiceItem(InvoiceItem invoiceItem) =>
      update<InvoiceItem>(
          "/invoiceitems", invoiceItem.id, () => invoiceItem.toJson());

  // DELETE
  Future<DocumentReference> deleteInvoiceItem(String id) =>
      delete<InvoiceItem>("/invoiceitems", id);

  // Receipt QUERY
  // SINGLE
  Stream<Receipt> streamReceipt(String id) => _streamSingle<Receipt>(
      id, "/receipts", (id, json) => Receipt.fromJson(id, json));

  // MULTIPLE
  Stream<List<Receipt>> streamReceipts() => _streamMultiple<Receipt>(
      "/receipts", (id, json) => Receipt.fromJson(id, json));

  // Receipt COMMAND
  // CREATE
  Future<DocumentReference> addReceipt(Receipt receipt) =>
      add<Receipt>("/receipts", () => receipt.toJson());

  // UPDATE
  Future<DocumentReference> updateReceipt(Receipt receipt) =>
      update<Receipt>("/receipts", receipt.id, () => receipt.toJson());

  // DELETE
  Future<DocumentReference> deleteReceipt(String id) =>
      delete<Receipt>("/receipts", id);

  // Account QUERY
  // SINGLE
  Stream<Account> streamAccount(String id) => _streamSingle<Account>(
      id, "/accounts", (id, json) => Account.fromJson(id, json));

  // MULTIPLE
  Stream<List<Account>> streamAccounts() => _streamMultiple<Account>(
      "/accounts", (id, json) => Account.fromJson(id, json));

  // Account COMMAND
  // CREATE
  Future<DocumentReference> addAccount(Account account) =>
      add<Account>("/accounts", () => account.toJson());

  // UPDATE
  Future<DocumentReference> updateAccount(Account account) =>
      update<Account>("/accounts", account.id, () => account.toJson());

  // DELETE
  Future<DocumentReference> deleteAccount(String id) =>
      delete<Account>("/accounts", id);

  // Transaction QUERY
  // SINGLE
  Stream<TransactionModel> streamTransactionModel(String id) =>
      _streamSingle<TransactionModel>(id, "/transactions",
          (id, json) => TransactionModel.fromJson(id, json));

  // MULTIPLE
  Stream<List<TransactionModel>> streamTransactionModels() =>
      _streamMultiple<TransactionModel>(
          "/transactions", (id, json) => TransactionModel.fromJson(id, json));

  // TransactionModel COMMAND
  // CREATE
  Future<DocumentReference> addTransactionModel(
          TransactionModel transactionModel) =>
      add<TransactionModel>(
          "/transactionmodels", () => transactionModel.toJson());

  // UPDATE
  Future<DocumentReference> updateTransactionModel(
          TransactionModel transactionModel) =>
      update<TransactionModel>("/transactionmodels", transactionModel.id,
          () => transactionModel.toJson());

  // DELETE
  Future<DocumentReference> deleteTransactionModel(String id) =>
      delete<TransactionModel>("/transactionmodels", id);

  // Currency QUERY
  // SINGLE
  Stream<Currency> streamCurrency(String id) => _streamSingle<Currency>(
      id, "/currencies", (id, json) => Currency.fromJson(id, json));

  // MULTIPLE
  Stream<List<Currency>> streamCurrencies() => _streamMultiple<Currency>(
      "/currencies", (id, json) => Currency.fromJson(id, json));

  // Currency COMMAND
  // CREATE
  Future<DocumentReference> addCurrency(Currency currency) =>
      add<Currency>("/currencies", () => currency.toJson());

  // UPDATE
  Future<DocumentReference> updateCurrency(Currency currency) =>
      update<Currency>("/currencies", currency.id, () => currency.toJson());

  // DELETE
  Future<DocumentReference> deleteCurrency(String id) =>
      delete<Currency>("/currencies", id);

  // Address QUERY
  // SINGLE
  Stream<Address> streamAddress(String id) => _streamSingle<Address>(
      id, "/addresses", (id, json) => Address.fromJson(id, json));

  // MULTIPLE
  Stream<List<Address>> streamAddresss() => _streamMultiple<Address>(
      "/addresses", (id, json) => Address.fromJson(id, json));

  // Address COMMAND
  // CREATE
  Future<DocumentReference> addAddress(Address address) =>
      add<Address>("/addresss", () => address.toJson());

  // UPDATE
  Future<DocumentReference> updateAddress(Address address) =>
      update<Address>("/addresss", address.id, () => address.toJson());

  // DELETE
  Future<DocumentReference> deleteAddress(String id) =>
      delete<Address>("/addresss", id);

  // DOPE
}
