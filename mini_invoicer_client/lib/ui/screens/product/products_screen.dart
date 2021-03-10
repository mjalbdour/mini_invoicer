import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/product/product_screen.dart';
import "package:provider/provider.dart";

class ProductsScreen extends StatelessWidget {
  static const String ROUTE = "/products";
  @override
  Widget build(BuildContext context) {
    final _productsStream =
        context.watch<FirebaseCloudFirestoreService>().streamProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
        initialData: [],
        stream: _productsStream,
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

          var _products = snapshot.data;
          if (_products.isEmpty) {
            return Center(
              child: Text("No products found"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _products.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductScreen(_products[index].id))),
                child: Container(
                  height: 100.0,
                  child: Card(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 0,
                        width: 0,
                      ),
                      Text("${_products[index].name}"),
                      Container(
                        color: _products[index].requiresRefrigeration
                            ? Colors.lightBlue
                            : Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_products[index].weight}g",
                              style: TextStyle(color: Colors.white),
                            ),
                            _products[index].requiresRefrigeration
                                ? Icon(
                                    Icons.ac_unit_outlined,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.device_thermostat,
                                    color: Colors.white,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
