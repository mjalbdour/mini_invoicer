import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
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

  // Product QUERY
  // SINGLE
  Stream<Product> streamProduct(String id) => _streamSingle<Product>(
      id, 'products', (id, json) => Product.fromJson(id, json));

  // MULTIPLE
  Stream<List<Product>> streamProducts() => _streamMultiple<Product>(
      'products', (id, json) => Product.fromJson(id, json));

  // Vendor QUERY
  // SINGLE
  Stream<Vendor> streamVendor(String id) => _streamSingle<Vendor>(
      id, 'vendors', (id, json) => Vendor.fromJson(id, json));
}
