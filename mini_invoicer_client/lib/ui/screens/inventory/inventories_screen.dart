import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
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
      ),
      body: StreamBuilder<List<Inventory>>(
        initialData: [],
        stream: _inventoriesStream,
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
              child: Text("No inventories found"),
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
                      Text("${_inventories[index].name}"),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_inventories[index].inventoryTypeId}",
                              style: TextStyle(color: Colors.white),
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
