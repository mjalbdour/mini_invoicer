import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/pricing_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class PricingTypeAddScreen extends StatefulWidget {
  static const String ROUTE = "/pricingtypes/add";

  @override
  _PricingTypeAddScreenState createState() => _PricingTypeAddScreenState();
}

class _PricingTypeAddScreenState extends State<PricingTypeAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  PricingType _pricingType = PricingType();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Pricing Type"),
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
                labelText: "Pricing Type Title",
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
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _pricingType.title = _titleController.text.trim();
                    _pricingType.description = _descriptionController.text.trim();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addPricingType(_pricingType);
                    if (docRef == null) {
                      print("Error adding pricing type");
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
