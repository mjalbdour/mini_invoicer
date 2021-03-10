import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';

class FirebaseCloudFirestoreService {
  final FirebaseFirestore _db;
  FirebaseCloudFirestoreService(this._db);

  // Product QUERY
  Stream<Product> streamProduct(String id) => _db
      .collection('products')
      .doc(id)
      .snapshots()
      .map((snapshot) => Product.fromJson(id, snapshot.data()));

  Stream<Set<Product>> streamProducts() =>
      _db.collection('products').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Product.fromJson(
                    doc.id,
                    doc.data(),
                  ),
                )
                .toSet(),
          );
}
