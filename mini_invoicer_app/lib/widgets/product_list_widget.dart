import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/services/cloud_firestore_service.dart';
import 'package:mini_invoicer_app/widgets/product_tile_widget.dart';
import 'package:provider/provider.dart';

class ProductListWidget extends StatefulWidget {
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context);
    return StreamBuilder<List<Product>>(
        stream: firestore.products,
        builder: (BuildContext _, AsyncSnapshot<List<Product>> snapshot) {
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
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext _, int index) {
                    return ProductTile(product: snapshot.data[index]);
                  });
          }
        });
  }
}
