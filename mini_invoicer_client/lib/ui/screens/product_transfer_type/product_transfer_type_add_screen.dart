import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class ProductTransferTypeAddScreen extends StatefulWidget {
  static const String ROUTE = "/producttransfertypes/add";

  @override
  _ProductTransferTypeAddScreenState createState() => _ProductTransferTypeAddScreenState();
}

class _ProductTransferTypeAddScreenState extends State<ProductTransferTypeAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  ProductTransferType _productTransferType = ProductTransferType();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Image"),
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
              onSaved: (value) => _productTransferType.title = value.trim(),
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextFormField(
              onSaved: (value) =>
                  _productTransferType.description = value.trim(),
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState.save();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addProductTransferType(_productTransferType);

                    if (docRef == null) {
                      print("Error adding product transfer type");
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
