import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class InventoryTypeScreen extends StatelessWidget {
  final String _id;
  InventoryTypeScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<InventoryType> _inventoryTypeStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventoryType(_id);
    return StreamBuilder<InventoryType>(
      initialData: InventoryType(),
      stream: _inventoryTypeStream,
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

        InventoryType _inventoryType = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_inventoryType.name}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_inventoryType.description}"),
            ],
          ),
        );
      },
    );
  }
}
