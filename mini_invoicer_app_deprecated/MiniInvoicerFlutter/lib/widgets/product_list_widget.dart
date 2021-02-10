import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/services/firestore_service.dart';
import 'package:mini_invoicer_app/widgets/product_tile_widget.dart';
import 'package:provider/provider.dart';

class ProductListWidget extends StatefulWidget {
  final String collectionPath;
  ProductListWidget({@required this.collectionPath});
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    return StreamBuilder<List<Product>>(
        stream: firestoreService.products,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
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
                  itemBuilder: (BuildContext context, int index) {
                    return ProductTile(
                      product: snapshot.data[index],
                    );
                  });
          }
        });
  }
}
