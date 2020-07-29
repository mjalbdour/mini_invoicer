import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/screens/product/product_create_edit_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const String title = "products";
  static const String route = "/$title";

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final CollectionReference _products =
      Firestore.instance.collection("/products");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductListScreen.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductCreateEditScreen(
                    product: Product(),
                  )));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _products.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ProductTile(
                    product: Product.fromMap(
                        snapshot.data.documents[index].data,
                        snapshot.data.documents[index].documentID),
                  );
                },
                itemCount: snapshot.data.documents.length,
              );
          }
        },
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({@required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product)));
      },
    );
  }
}
