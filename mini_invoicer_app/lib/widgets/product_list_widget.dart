import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/widgets/product_tile_widget.dart';

class ProductListWidget extends StatefulWidget {
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("/products").snapshots(),
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
            return snapshot.data.documents.isEmpty
                ? Center(
                    child: Text("no products yet"),
                  )
                : ListView.builder(
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
    );
  }
}
