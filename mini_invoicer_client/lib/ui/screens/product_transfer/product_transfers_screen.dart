import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer/product_transfer_screen.dart';
import "package:provider/provider.dart";

class ProductTransfersScreen extends StatelessWidget {
  static const String ROUTE = "/producttransfers";
  @override
  Widget build(BuildContext context) {
    final _pricingTypesStream =
        context.watch<FirebaseCloudFirestoreService>().streamProductTransfers();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Transfers"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ProductTransfer>>(
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

          var _productTransfers = snapshot.data;
          if (_productTransfers.isEmpty) {
            return Center(
              child: Text("No product transfers found"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _productTransfers.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductTransferScreen(_productTransfers[index].id))),
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
                        Text("${_productTransfers[index].id}"),
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${_productTransfers[index].quantity}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
