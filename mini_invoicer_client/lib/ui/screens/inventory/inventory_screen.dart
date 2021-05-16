import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatelessWidget {
  final String _id;
  InventoryScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<Inventory> _inventoryStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventory(_id);
    return StreamBuilder<Inventory>(
      initialData: Inventory(),
      stream: _inventoryStream,
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

        Inventory _inventory = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_inventory.title}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_inventory.ownerId}"),
              Text("${_inventory.inventoryTypeId}"),
              Text("${_inventory.lastUpdated}"),
            ],
          ),
        );
      },
    );
  }
}
