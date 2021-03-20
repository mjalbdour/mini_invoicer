import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class CustomerAddScreen extends StatefulWidget {
  static const String ROUTE = "/customers/add";

  @override
  _CustomerAddScreenState createState() => _CustomerAddScreenState();
}

class _CustomerAddScreenState extends State<CustomerAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Customer _customer = Customer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
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
                labelText: "Customer Name",
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
                    _customer.name = _nameController.text.trim();
                    _customer.description = _descriptionController.text.trim();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addCustomer(_customer);

                    if (docRef == null) {
                      print("Error adding customer");
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
