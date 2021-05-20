import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_quantity_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/product_quantity/product_quantity_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_quantity/product_quantity_screen.dart';
import "package:provider/provider.dart";

class ProductQuantitiesScreen extends StatelessWidget {
  static const String ROUTE = "/productquantities";

  @override
  Widget build(BuildContext context) {
    final _pricingTypesStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamProductQuantities();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Transfers"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context)
                  .pushNamed(ProductQuantityAddScreen.ROUTE))
        ],
      ),
      body: StreamBuilder<List<ProductQuantity>>(
        initialData: [],
        stream: _pricingTypesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Oops! Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var _productQuantities = snapshot.data;
          if (_productQuantities.isEmpty) {
            return Center(
              child: Text("No product quantities found"),
            );
          }

          return ListView.builder(
              itemCount: _productQuantities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProductQuantityScreen(_productQuantities[index].id))),
                  title: Text("${_productQuantities[index].quantity}"),
                  trailing: Text("${_productQuantities[index].inventoryId}"),
                  subtitle: Text("${_productQuantities[index].productId}"),
                );
              });
        },
      ),
    );
  }
}
