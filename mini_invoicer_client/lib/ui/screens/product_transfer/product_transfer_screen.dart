import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class ProductTransferScreen extends StatelessWidget {
  final String _id;
  ProductTransferScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<ProductTransfer> _productTransferStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamProductTransfer(_id);
    return StreamBuilder<ProductTransfer>(
      initialData: ProductTransfer(),
      stream: _productTransferStream,
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

        ProductTransfer _productTransfer = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_productTransfer.value}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_productTransfer.description}"),
            ],
          ),
        );
      },
    );
  }
}
