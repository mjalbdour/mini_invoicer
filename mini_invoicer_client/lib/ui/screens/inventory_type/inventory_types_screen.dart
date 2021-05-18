import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/inventory/inventory_screen.dart';
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

          var _inventories = snapshot.data;
          if (_inventories.isEmpty) {
            return Center(
              child: Text("No inventory types found"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _inventories.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        InventoryScreen(_inventories[index].id))),
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
                      Text("${_inventories[index].title}"),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.ac_unit_outlined,
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
