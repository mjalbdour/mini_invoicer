import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/product_model.dart';

class FirestoreService {
  final _firestore = Firestore.instance;

  Stream<List<Product>> get products {
    return _firestore.collection("/products").getDocuments().asStream().map(
          (stream) => stream.documents.map(
            (doc) => Product.fromMap(doc.data, doc.documentID),
          ),
        );
  }

  Stream<List<Customer>> get customers {
    return _firestore.collection("/customers").getDocuments().asStream().map(
        (stream) => stream.documents
            .map((doc) => Customer.fromMap(doc.data, doc.documentID)));
  }
}
