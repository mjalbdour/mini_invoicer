import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer_type/product_transfer_type_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer_type/product_transfer_type_screen.dart';
import "package:provider/provider.dart";

class ProductTransferTypesScreen extends StatelessWidget {
  static const String ROUTE = "/producttransfertypes";

  @override
  Widget build(BuildContext context) {
    final _productTransferTypesStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamProductTransferTypes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                .pushNamed(ProductTransferTypeAddScreen.ROUTE),
          )
        ],
      ),
      body: StreamBuilder<List<ProductTransferType>>(
        initialData: [],
        stream: _productTransferTypesStream,
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

          var _productTransferTypes = snapshot.data;
          if (_productTransferTypes.isEmpty) {
            return Center(
              child: Text("No product transfer types found"),
            );
          }

          return ListView.builder(
              itemCount: _productTransferTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductTransferTypeScreen(
                          _productTransferTypes[index].id))),
                  title: Text("${_productTransferTypes[index].title}"),
                  subtitle: Text("${_productTransferTypes[index].description}"),
                );
              });
        },
      ),
    );
  }
}
