import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class InventoryTypeAddScreen extends StatefulWidget {
  static const String ROUTE = "/inventorytypes/add";

  @override
  _InventoryTypeAddScreenState createState() => _InventoryTypeAddScreenState();
}

class _InventoryTypeAddScreenState extends State<InventoryTypeAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  InventoryType _inventoryType = InventoryType();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add InventoryType"),
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
                labelText: "Inventory Type Title",
              ),
            ),
            TextFormField(
              autofocus: true,
              onFieldSubmitted: (value) {
                value = value.trim();
              },
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            DropdownButtonFormField<bool>(
              value: false,
              onChanged: (value) => _inventoryType.refrigerated = value,
              onSaved: (value) => _inventoryType.refrigerated = value,
              decoration: InputDecoration(labelText: "Refrigerated?"),
              items: <DropdownMenuItem<bool>>[
                DropdownMenuItem(value: false, child: Text("No")),
                DropdownMenuItem(value: true, child: Text("Yes")),
              ],
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _inventoryType.title = _titleController.text.trim();
                    _inventoryType.description =
                        _descriptionController.text.trim();
                    _formKey.currentState.save();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addInventoryType(_inventoryType);

                    if (docRef == null) {
                      print("Error adding inventory type");
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
