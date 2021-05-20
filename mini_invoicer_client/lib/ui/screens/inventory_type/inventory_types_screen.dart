import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/inventory_type/inventory_type_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/inventory_type/inventory_type_screen.dart';
import "package:provider/provider.dart";

class InventoryTypesScreen extends StatelessWidget {
  static const String ROUTE = "/inventorytypes";

  @override
  Widget build(BuildContext context) {
    final _inventoryTypesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventoryTypes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Types"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(InventoryTypeAddScreen.ROUTE),
          ),
        ],
      ),
      body: StreamBuilder<List<InventoryType>>(
        initialData: [],
        stream: _inventoryTypesStream,
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

          var _inventoryTypes = snapshot.data;
          if (_inventoryTypes.isEmpty) {
            return Center(
              child: Text("No inventory types found"),
            );
          }

          return ListView.builder(
              itemCount: _inventoryTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          InventoryTypeScreen(_inventoryTypes[index].id))),
                  title: Text("${_inventoryTypes[index].title}"),
                  subtitle: Text("${_inventoryTypes[index].description}"),
                  trailing: _inventoryTypes[index].refrigerated
                      ? Icon(Icons.ac_unit)
                      : Icon(Icons.thermostat_rounded),
                );
              });
        },
      ),
    );
  }
}
