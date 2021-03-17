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
  Future<DocumentReference> addProduct(Product product) async {
    DocumentReference docRef;
    try {
      docRef = await _db.collection("/products").add(product.toJson());
    } catch (ex) {
      print(ex);
      throw ex;
    }
    return docRef;
  }

  // UPDATE
  Future<DocumentReference> updateProduct(Product product) async {
    DocumentReference docRef;
    try {
      docRef = _db.doc("products/${product.id}");
      await docRef.update(product.toJson());
    } on FirebaseException catch (ex) {
      print(ex);
      throw ex;
    }
    return docRef;
  }

  // DELETE
  Future<DocumentReference> deleteProduct(String id) async {
    DocumentReference docRef;
    try {
      docRef = _db.doc("products/$id");
      await docRef.delete();
    } on FirebaseException catch (ex) {
      print(ex);
      throw ex;
    }
    return docRef;
  }

  // PricingType QUERY
  // SINGLE
  Stream<PricingType> streamPricingType(String id) =>
      _streamSingle<PricingType>(
          id, 'pricingtypes', (id, json) => PricingType.fromJson(id, json));

  // MULTIPLE
  Stream<List<PricingType>> streamPricingTypes() =>
      _streamMultiple<PricingType>(
          'pricingtypes', (id, json) => PricingType.fromJson(id, json));

  // ProductPricing QUERY
  // SINGLE
  Stream<ProductPricing> streamProductPricing(String id) =>
      _streamSingle<ProductPricing>(id, 'productpricings',
          (id, json) => ProductPricing.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductPricing>> streamProductPricings() =>
      _streamMultiple<ProductPricing>(
          'productpricings', (id, json) => ProductPricing.fromJson(id, json));

  // Vendor QUERY
  // SINGLE
  Stream<Vendor> streamVendor(String id) => _streamSingle<Vendor>(
      id, 'vendors', (id, json) => Vendor.fromJson(id, json));

  // Employee QUERY
  // SINGLE
  Stream<Employee> streamEmployee(String id) => _streamSingle<Employee>(
      id, 'employees', (id, json) => Employee.fromJson(id, json));

  // MULTIPLE
  Stream<List<Employee>> streamEmployees() => _streamMultiple<Employee>(
      'employees', (id, json) => Employee.fromJson(id, json));

  // Brand QUERY
  // SINGLE
  Stream<Brand> streamBrand(String id) => _streamSingle<Brand>(
      id, 'brands', (id, json) => Brand.fromJson(id, json));

  // MULTIPLE
  Stream<List<Brand>> streamBrands() =>
      _streamMultiple<Brand>('brands', (id, json) => Brand.fromJson(id, json));

  // Customer QUERY
  // SINGLE
  Stream<Customer> streamCustomer(String id) => _streamSingle<Customer>(
      id, 'customers', (id, json) => Customer.fromJson(id, json));

  // MULTIPLE
  Stream<List<Customer>> streamCustomers() => _streamMultiple<Customer>(
      'customers', (id, json) => Customer.fromJson(id, json));

  // ImageModel QUERY
  // SINGLE
  Stream<ImageModel> streamImageModel(String id) => _streamSingle<ImageModel>(
      id, 'images', (id, json) => ImageModel.fromJson(id, json));

  // MULTIPLE
  Stream<List<ImageModel>> streamImageModels() => _streamMultiple<ImageModel>(
      'images', (id, json) => ImageModel.fromJson(id, json));

  // Inventory QUERY
  // SINGLE
  Stream<Inventory> streamInventory(String id) => _streamSingle<Inventory>(
      id, 'inventories', (id, json) => Inventory.fromJson(id, json));

  // MULTIPLE
  Stream<List<Inventory>> streamInventories() => _streamMultiple<Inventory>(
      'inventories', (id, json) => Inventory.fromJson(id, json));

  // InventoryType QUERY
  // SINGLE
  Stream<InventoryType> streamInventoryType(String id) =>
      _streamSingle<InventoryType>(
          id, 'inventorytypes', (id, json) => InventoryType.fromJson(id, json));

  // MULTIPLE
  Stream<List<InventoryType>> streamInventoryTypes() =>
      _streamMultiple<InventoryType>(
          'inventorytypes', (id, json) => InventoryType.fromJson(id, json));

  // ProductTransfer QUERY
  // SINGLE
  Stream<ProductTransfer> streamProductTransfer(String id) =>
      _streamSingle<ProductTransfer>(id, 'producttransfers',
          (id, json) => ProductTransfer.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductTransfer>> streamProductTransfers() =>
      _streamMultiple<ProductTransfer>(
          'producttransfers', (id, json) => ProductTransfer.fromJson(id, json));

  // ProductTransferType QUERY
  // SINGLE
  Stream<ProductTransferType> streamProductTransferType(String id) =>
      _streamSingle<ProductTransferType>(id, 'producttransfertypes',
          (id, json) => ProductTransferType.fromJson(id, json));

  // MULTIPLE
  Stream<List<ProductTransferType>> streamProductTransferTypes() =>
      _streamMultiple<ProductTransferType>('producttransfertypes',
          (id, json) => ProductTransferType.fromJson(id, json));

  // Invoice QUERY
  // SINGLE
  Stream<Invoice> streamInvoice(String id) => _streamSingle<Invoice>(
      id, 'invoices', (id, json) => Invoice.fromJson(id, json));

  // MULTIPLE
  Stream<List<Invoice>> streamInvoices() => _streamMultiple<Invoice>(
      'invoices', (id, json) => Invoice.fromJson(id, json));

  // InvoiceItem QUERY
  // SINGLE
  Stream<InvoiceItem> streamInvoiceItem(String id) =>
      _streamSingle<InvoiceItem>(
          id, 'invoiceitems', (id, json) => InvoiceItem.fromJson(id, json));

  // MULTIPLE
  Stream<List<InvoiceItem>> streamInvoiceItems() =>
      _streamMultiple<InvoiceItem>(
          'invoiceitems', (id, json) => InvoiceItem.fromJson(id, json));

  // Receipt QUERY
  // SINGLE
  Stream<Receipt> streamReceipt(String id) => _streamSingle<Receipt>(
      id, 'receipts', (id, json) => Receipt.fromJson(id, json));

  // MULTIPLE
  Stream<List<Receipt>> streamReceipts() => _streamMultiple<Receipt>(
      'receipts', (id, json) => Receipt.fromJson(id, json));

  // Account QUERY
  // SINGLE
  Stream<Account> streamAccount(String id) => _streamSingle<Account>(
      id, 'accounts', (id, json) => Account.fromJson(id, json));

  // MULTIPLE
  Stream<List<Account>> streamAccounts() => _streamMultiple<Account>(
      'accounts', (id, json) => Account.fromJson(id, json));

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
