import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/core/models/inventory_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class InventoryAddScreen extends StatefulWidget {
  static const String ROUTE = "/inventories/add";

  @override
  _InventoryAddScreenState createState() => _InventoryAddScreenState();
}

class _InventoryAddScreenState extends State<InventoryAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  Inventory _inventory = Inventory();

  @override
  Widget build(BuildContext context) {
    Stream<List<InventoryType>> _inventoryTypesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventoryTypes();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Inventory"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              autofocus: true,
              onFieldSubmitted: (value) {
                value = value.trim();
              },
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Inventory Title",
              ),
            ),
            StreamBuilder<List<InventoryType>>(
              initialData: [],
              stream: _inventoryTypesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error loading inventory types");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        Center(child: Text("Please add inventory types first")),
                  );
                }

                var _inventoryTypes = snapshot.data;

                return DropdownButtonFormField<String>(
                  onChanged: (value) => _inventory.inventoryTypeId = value,
                  onSaved: (value) => _inventory.inventoryTypeId = value,
                  decoration: InputDecoration(labelText: "Inventory Type"),
                  items: _inventoryTypes
                      .map((inventoryType) => DropdownMenuItem<String>(
                          key: Key(inventoryType.id),
                          value: inventoryType.id,
                          child: Text("${inventoryType.title}")))
                      .toList(),
                );
              },
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _inventory.title = _titleController.text.trim();
                    _inventory.lastUpdated = DateTime.now();
                    _formKey.currentState.save();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addInventory(_inventory);

                    if (docRef == null) {
                      print("Error adding inventory");
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Add"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
