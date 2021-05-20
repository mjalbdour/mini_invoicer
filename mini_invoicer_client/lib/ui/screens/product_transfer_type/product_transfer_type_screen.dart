import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class ProductTransferTypeScreen extends StatelessWidget {
  final String _id;

  ProductTransferTypeScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<ProductTransferType> _productTransferTypeStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamProductTransferType(_id);
    return StreamBuilder<ProductTransferType>(
      initialData: ProductTransferType(),
      stream: _productTransferTypeStream,
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

        ProductTransferType _productTransferType = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_productTransferType.title}"),
            actions: [
              IconButton(icon: Icon(Icons.edit), onPressed: () => null),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_productTransferType.title}"),
              Text("${_productTransferType.description}"),
            ],
          ),
        );
      },
    );
  }
}
