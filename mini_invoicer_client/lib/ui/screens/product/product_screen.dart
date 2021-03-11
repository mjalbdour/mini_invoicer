import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  String _id;
  String _route;
  ProductScreen(String id) {
    this._id = id;
    this._route = "/products/$id";
  }

  @override
  Widget build(BuildContext context) {
    Stream<Product> _productStream =
        context.watch<FirebaseCloudFirestoreService>().streamProduct(_id);
    return StreamBuilder<Product>(
      initialData: Product(),
      stream: _productStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text("Oops! Something went wrong"),
                  IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        Product _product = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_product.name}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_product.weight}g"),
              Text("${_product.description}"),
              Text(_product.requiresRefrigeration
                  ? "Requires refrigeration"
                  : "Reserved in ambient temperature"),
            ],
          ),
        );
      },
    );
  }
}