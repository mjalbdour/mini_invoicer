import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/inventory/inventory_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/inventory/inventory_screen.dart';
import "package:provider/provider.dart";

class InventoriesScreen extends StatelessWidget {
  static const String ROUTE = "/inventories";

  @override
  Widget build(BuildContext context) {
    final _inventoriesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventories();
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventories"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(InventoryAddScreen.ROUTE))
        ],
      ),
      body: StreamBuilder<List<Inventory>>(
        initialData: [],
        stream: _inventoriesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Oops! Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var _inventories = snapshot.data;
          if (_inventories.isEmpty) {
            return Center(
              child: Text("No inventories found"),
            );
          }

          return ListView.builder(
              itemCount: _inventories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${_inventories[index].title}"),
                  subtitle: Text("Last Updated: ${_inventories[index].lastUpdated}"),
                );
              });
        },
      ),
    );
  }
}
