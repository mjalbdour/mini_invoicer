import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/screens/product/product_create_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const String title = "products";
  static const String route = "/$title";

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
//  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
//    return snapshot.documents.map((document) => Product(
//      name: document.data["name"]
//    )).toList();
//  }

  final CollectionReference _products =
      Firestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductListScreen.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ProductCreateScreen.route);
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _products.orderBy("name").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data.documents[index].data["name"] ??
                        "name not available"),
                  );
                },
                itemCount: snapshot.data.documents.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
