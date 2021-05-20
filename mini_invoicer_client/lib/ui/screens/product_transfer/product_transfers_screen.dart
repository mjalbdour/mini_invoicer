import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer/product_transfer_add_screen.dart';
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
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context)
                  .pushNamed(ProductTransferAddScreen.ROUTE))
        ],
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

          return ListView.builder(
            itemCount: _productTransfers.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductTransferScreen(_productTransfers[index].id))),
                trailing: Text("${_productTransfers[index].productId}"),
                title: Text("${_productTransfers[index].quantity}"),
                subtitle: Text(
                    "${_productTransfers[index].fromInventoryId} to ${_productTransfers[index].toInventoryId}"),
              );
            },
          );
        },
      ),
    );
  }
}
