import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/countries_data.dart';
import "package:provider/provider.dart";

class BrandAddScreen extends StatefulWidget {
  static const String ROUTE = "/brands/add";

  @override
  _BrandAddScreenState createState() => _BrandAddScreenState();
}

class _BrandAddScreenState extends State<BrandAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Brand _brand = Brand();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Brand"),
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
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Brand Name",
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
              ),
              onFieldSubmitted: (value) {
                value = value.trim();
              },
            ),
            DropdownButtonFormField<String>(
              value: countries[111],
              onChanged: (value) => _brand.country = value,
              decoration: InputDecoration(labelText: "Brand"),
              items: countries
                  .map((country) => DropdownMenuItem(
                        child: Text("$country"),
                        value: country,
                      ))
                  .toList(),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _brand.name = _nameController.text.trim();
                    _brand.description = _descriptionController.text.trim();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addBrand(_brand);

                    if (docRef == null) {
                      print("Error adding brand");
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
