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
  Future<void> add<T>(String collectionPath, Map<String, dynamic> toJson()) =>
      _db
          .collection(collectionPath)
          .add(toJson())
          .then((value) => print("add successful"))
          .catchError((error) => print(error));

  // UPDATE
  Future<void> update<T>(
          String collectionPath, String id, Map<String, dynamic> toJson()) =>
      _db
          .collection(collectionPath)
          .doc(id)
          .update(toJson())
          .then((value) => print("update successul"))
          .catchError((error) => print(error));

  // DELETE
  Future<void> delete<T>(String collectionPath, String id) => _db
      .collection(collectionPath)
      .doc(id)
      .delete()
      .then((value) => print("delete successful"))
      .catchError((error) => print(error));

  // Product QUERY
  // SINGLE
  Stream<Product> streamProduct(String id) => _streamSingle<Product>(
      id, 'products', (id, json) => Product.fromJson(id, json));

  // MULTIPLE
  Stream<List<Product>> streamProducts() => _streamMultiple<Product>(
      'products', (id, json) => Product.fromJson(id, json));

  // Product COMMAND
  // CREATE
  Future<void> addProduct(Product product) =>
      add<Product>("/products", () => product.toJson());

  // UPDATE
  Future<void> updateProduct(Product product) =>
      update<Product>("/products", product.id, () => product.toJson());

  // DELETE
  Future<void> deleteProduct(String id) => delete<Product>("/products", id);

  // PricingType QUERY
  // SINGLE
  Stream<PricingType> streamPricingType(String id) =>
      _streamSingle<PricingType>(
          id, 'pricingtypes', (id, json) => PricingType.fromJson(id, json));

  // MULTIPLE
  Stream<List<PricingType>> streamPricingTypes() =>
      _streamMultiple<PricingType>(
          'pricingtypes', (id, json) => PricingType.fromJson(id, json));

  // PricingType COMMAND
  // CREATE
  Future<void> addPricingType(PricingType pricingType) =>
      add<PricingType>("/pricingtypes", () => pricingType.toJson());

  // UPDATE
  Future<void> updatePricingType(PricingType pricingType) =>
      update<PricingType>(
          "/pricingtypes", pricingType.id, () => pricingType.toJson());

  // DELETE
  Future<void> deletePricingType(String id) =>
      delete<PricingType>("/pricingtypes", id);

  // ProductPricing QUERY
  // SINGLE
  Stream<ProductPricing> streamProductPricing(String id) =>
      _streamSingle<ProductPricing>(id, 'productpricings',
          (id, json) => ProductPricing.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductPricing>> streamProductPricings() =>
      _streamMultiple<ProductPricing>(
          'productpricings', (id, json) => ProductPricing.fromJson(id, json));

  // ProductPricing COMMAND
  // CREATE
  Future<void> addProductPricing(ProductPricing pricingType) =>
      add<ProductPricing>("/productpricings", () => pricingType.toJson());

  // UPDATE
  Future<void> updateProductPricing(ProductPricing pricingType) =>
      update<ProductPricing>(
          "/productpricings", pricingType.id, () => pricingType.toJson());

  // DELETE
  Future<void> deleteProductPricing(String id) =>
      delete<ProductPricing>("/productpricings", id);

  // Vendor QUERY
  // SINGLE
  Stream<Vendor> streamVendor(String id) => _streamSingle<Vendor>(
      id, 'vendors', (id, json) => Vendor.fromJson(id, json));

  // Vendor COMMAND
  // CREATE
  Future<void> addVendor(Vendor vendor) =>
      add<Vendor>("/vendors", () => vendor.toJson());

  // UPDATE
  Future<void> updateVendor(Vendor vendor) =>
      update<Vendor>("/vendors", vendor.id, () => vendor.toJson());

  // DELETE
  Future<void> deleteVendor(String id) => delete<Vendor>("/vendors", id);

  // Employee QUERY
  // SINGLE
  Stream<Employee> streamEmployee(String id) => _streamSingle<Employee>(
      id, 'employees', (id, json) => Employee.fromJson(id, json));

  // MULTIPLE
  Stream<List<Employee>> streamEmployees() => _streamMultiple<Employee>(
      'employees', (id, json) => Employee.fromJson(id, json));

  // Employee COMMAND
  // CREATE
  Future<void> addEmployee(Employee employee) =>
      add<Employee>("/employees", () => employee.toJson());

  // UPDATE
  Future<void> updateEmployee(Employee employee) =>
      update<Employee>("/employees", employee.id, () => employee.toJson());

  // DELETE
  Future<void> deleteEmployee(String id) => delete<Employee>("/employees", id);

  // Brand QUERY
  // SINGLE
  Stream<Brand> streamBrand(String id) => _streamSingle<Brand>(
      id, 'brands', (id, json) => Brand.fromJson(id, json));

  // MULTIPLE
  Stream<List<Brand>> streamBrands() =>
      _streamMultiple<Brand>('brands', (id, json) => Brand.fromJson(id, json));

  // Brand COMMAND
  // CREATE
  Future<void> addBrand(Brand brand) =>
      add<Brand>("/brands", () => brand.toJson());

  // UPDATE
  Future<void> updateBrand(Brand brand) =>
      update<Brand>("/brands", brand.id, () => brand.toJson());

  // DELETE
  Future<void> deleteBrand(String id) => delete<Brand>("/brands", id);

  // Customer QUERY
  // SINGLE
  Stream<Customer> streamCustomer(String id) => _streamSingle<Customer>(
      id, 'customers', (id, json) => Customer.fromJson(id, json));

  // MULTIPLE
  Stream<List<Customer>> streamCustomers() => _streamMultiple<Customer>(
      'customers', (id, json) => Customer.fromJson(id, json));

  // Customer COMMAND
  // CREATE
  Future<void> addCustomer(Customer customer) =>
      add<Customer>("/customers", () => customer.toJson());

  // UPDATE
  Future<void> updateCustomer(Customer customer) =>
      update<Customer>("/customers", customer.id, () => customer.toJson());

  // DELETE
  Future<void> deleteCustomer(String id) => delete<Customer>("/customers", id);

  // ImageModel QUERY
  // SINGLE
  Stream<ImageModel> streamImageModel(String id) => _streamSingle<ImageModel>(
      id, 'images', (id, json) => ImageModel.fromJson(id, json));

  // MULTIPLE
  Stream<List<ImageModel>> streamImageModels() => _streamMultiple<ImageModel>(
      'images', (id, json) => ImageModel.fromJson(id, json));

  // ImageModel COMMAND
  // CREATE
  Future<void> addImageModel(ImageModel imageModel) =>
      add<ImageModel>("/imagemodels", () => imageModel.toJson());

  // UPDATE
  Future<void> updateImageModel(ImageModel imageModel) => update<ImageModel>(
      "/imagemodels", imageModel.id, () => imageModel.toJson());

  // DELETE
  Future<void> deleteImageModel(String id) =>
      delete<ImageModel>("/imagemodels", id);

  // Inventory QUERY
  // SINGLE
  Stream<Inventory> streamInventory(String id) => _streamSingle<Inventory>(
      id, 'inventories', (id, json) => Inventory.fromJson(id, json));

  // MULTIPLE
  Stream<List<Inventory>> streamInventories() => _streamMultiple<Inventory>(
      'inventories', (id, json) => Inventory.fromJson(id, json));

  // Inventory COMMAND
  // CREATE
  Future<void> addInventory(Inventory inventory) =>
      add<Inventory>("/inventories", () => inventory.toJson());

  // UPDATE
  Future<void> updateInventory(Inventory inventory) =>
      update<Inventory>("/inventories", inventory.id, () => inventory.toJson());

  // DELETE
  Future<void> deleteInventory(String id) =>
      delete<Inventory>("/inventories", id);

  // InventoryType QUERY
  // SINGLE
  Stream<InventoryType> streamInventoryType(String id) =>
      _streamSingle<InventoryType>(
          id, 'inventorytypes', (id, json) => InventoryType.fromJson(id, json));

  // MULTIPLE
  Stream<List<InventoryType>> streamInventoryTypes() =>
      _streamMultiple<InventoryType>(
          'inventorytypes', (id, json) => InventoryType.fromJson(id, json));

  // InventoryType COMMAND
  // CREATE
  Future<void> addInventoryType(InventoryType inventoryType) =>
      add<InventoryType>("/inventorytypes", () => inventoryType.toJson());

  // UPDATE
  Future<void> updateInventoryType(InventoryType inventoryType) =>
      update<InventoryType>(
          "/inventorytypes", inventoryType.id, () => inventoryType.toJson());

  // DELETE
  Future<void> deleteInventoryType(String id) =>
      delete<InventoryType>("/inventorytypes", id);

  // ProductTransfer QUERY
  // SINGLE
  Stream<ProductTransfer> streamProductTransfer(String id) =>
      _streamSingle<ProductTransfer>(id, 'producttransfers',
          (id, json) => ProductTransfer.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductTransfer>> streamProductTransfers() =>
      _streamMultiple<ProductTransfer>(
          'producttransfers', (id, json) => ProductTransfer.fromJson(id, json));

  // ProductTransfer COMMAND
  // CREATE
  Future<void> addProductTransfer(ProductTransfer productTransfer) =>
      add<ProductTransfer>("/producttransfers", () => productTransfer.toJson());

  // UPDATE
  Future<void> updateProductTransfer(ProductTransfer productTransfer) =>
      update<ProductTransfer>("/producttransfers", productTransfer.id,
          () => productTransfer.toJson());

  // DELETE
  Future<void> deleteProductTransfer(String id) =>
      delete<ProductTransfer>("/producttransfers", id);

  // ProductTransferType QUERY
  // SINGLE
  Stream<ProductTransferType> streamProductTransferType(String id) =>
      _streamSingle<ProductTransferType>(id, 'producttransfertypes',
          (id, json) => ProductTransferType.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductTransferType>> streamProductTransferTypes() =>
      _streamMultiple<ProductTransferType>('producttransfertypes',
          (id, json) => ProductTransferType.fromJson(id, json));

  // ProductTransferType COMMAND
  // CREATE
  Future<void> addProductTransferType(
          ProductTransferType productTransferType) =>
      add<ProductTransferType>(
          "/producttransfertypes", () => productTransferType.toJson());

  // UPDATE
  Future<void> updateProductTransferType(
          ProductTransferType productTransferType) =>
      update<ProductTransferType>("/producttransfertypes",
          productTransferType.id, () => productTransferType.toJson());

  // DELETE
  Future<void> deleteProductTransferType(String id) =>
      delete<ProductTransfer>("/producttransfertypes", id);

  // Invoice QUERY
  // SINGLE
  Stream<Invoice> streamInvoice(String id) => _streamSingle<Invoice>(
      id, 'invoices', (id, json) => Invoice.fromJson(id, json));

  // MULTIPLE
  Stream<List<Invoice>> streamInvoices() => _streamMultiple<Invoice>(
      'invoices', (id, json) => Invoice.fromJson(id, json));

  // Invoice COMMAND
  // CREATE
  Future<void> addInvoice(Invoice invoice) =>
      add<Invoice>("/invoices", () => invoice.toJson());

  // UPDATE
  Future<void> updateInvoice(Invoice invoice) =>
      update<Invoice>("/invoices", invoice.id, () => invoice.toJson());

  // DELETE
  Future<void> deleteInvoice(String id) => delete<Invoice>("/invoices", id);

  // InvoiceItem QUERY
  // SINGLE
  Stream<InvoiceItem> streamInvoiceItem(String id) =>
      _streamSingle<InvoiceItem>(
          id, 'invoiceitems', (id, json) => InvoiceItem.fromJson(id, json));

  // MULTIPLE
  Stream<List<InvoiceItem>> streamInvoiceItems() =>
      _streamMultiple<InvoiceItem>(
          'invoiceitems', (id, json) => InvoiceItem.fromJson(id, json));

  // InvoiceItem COMMAND
  // CREATE
  Future<void> addInvoiceItem(InvoiceItem invoiceItem) =>
      add<InvoiceItem>("/invoiceitems", () => invoiceItem.toJson());

  // UPDATE
  Future<void> updateInvoiceItem(InvoiceItem invoiceItem) =>
      update<InvoiceItem>(
          "/invoiceitems", invoiceItem.id, () => invoiceItem.toJson());

  // DELETE
  Future<void> deleteInvoiceItem(String id) =>
      delete<InvoiceItem>("/invoiceitems", id);

  // Receipt QUERY
  // SINGLE
  Stream<Receipt> streamReceipt(String id) => _streamSingle<Receipt>(
      id, 'receipts', (id, json) => Receipt.fromJson(id, json));

  // MULTIPLE
  Stream<List<Receipt>> streamReceipts() => _streamMultiple<Receipt>(
      'receipts', (id, json) => Receipt.fromJson(id, json));

  // Receipt COMMAND
  // CREATE
  Future<void> addReceipt(Receipt receipt) =>
      add<Receipt>("/receipts", () => receipt.toJson());

  // UPDATE
  Future<void> updateReceipt(Receipt receipt) =>
      update<Receipt>("/receipts", receipt.id, () => receipt.toJson());

  // DELETE
  Future<void> deleteReceipt(String id) => delete<Receipt>("/receipts", id);

  // Account QUERY
  // SINGLE
  Stream<Account> streamAccount(String id) => _streamSingle<Account>(
      id, 'accounts', (id, json) => Account.fromJson(id, json));

  // MULTIPLE
  Stream<List<Account>> streamAccounts() => _streamMultiple<Account>(
      'accounts', (id, json) => Account.fromJson(id, json));

  // Account COMMAND
  // CREATE
  Future<void> addAccount(Account account) =>
      add<Account>("/accounts", () => account.toJson());

  // UPDATE
  Future<void> updateAccount(Account account) =>
      update<Account>("/accounts", account.id, () => account.toJson());

  // DELETE
  Future<void> deleteAccount(String id) => delete<Account>("/accounts", id);

  // Transaction QUERY
  // SINGLE
  Stream<TransactionModel> streamTransactionModel(String id) =>
      _streamSingle<TransactionModel>(id, 'transactions',
          (id, json) => TransactionModel.fromJson(id, json));

  // MULTIPLE
  Stream<List<TransactionModel>> streamTransactionModels() =>
      _streamMultiple<TransactionModel>(
          'transactions', (id, json) => TransactionModel.fromJson(id, json));

  // Currency QUERY
  // SINGLE
  Stream<Currency> streamCurrency(String id) => _streamSingle<Currency>(
      id, 'currencies', (id, json) => Currency.fromJson(id, json));

  // MULTIPLE
  Stream<List<Currency>> streamCurrencies() => _streamMultiple<Currency>(
      'currencies', (id, json) => Currency.fromJson(id, json));

  // Address QUERY
  // SINGLE
  Stream<Address> streamAddress(String id) => _streamSingle<Address>(
      id, 'addresses', (id, json) => Address.fromJson(id, json));

  // MULTIPLE
  Stream<List<Address>> streamAddresss() => _streamMultiple<Address>(
      'addresses', (id, json) => Address.fromJson(id, json));
}
