import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/customer/customers_screen.dart';
import 'package:provider/provider.dart';

class CustomerUpdateScreen extends StatefulWidget {
  final String _id;
  CustomerUpdateScreen(this._id);

  @override
  _CustomerUpdateScreenState createState() => _CustomerUpdateScreenState();
}

class _CustomerUpdateScreenState extends State<CustomerUpdateScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Customer _oldCustomer = Customer();
  Customer _newCustomer = Customer();

  @override
  Widget build(BuildContext context) {
    Stream<Customer> _customerStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamCustomer(widget._id);

    return StreamBuilder<Customer>(
      initialData: Customer(),
      stream: _customerStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text("Oops! Something went wrong"),
                  IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text("Oops! Something went wrong"),
                  IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          );
        }

        _oldCustomer = snapshot.data;
        _nameController.text = _oldCustomer.name;
        _descriptionController.text = _oldCustomer.description;

        return Scaffold(
          appBar: AppBar(
            title: Text("Update ${_oldCustomer.name}"),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    showDialog<bool>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete this customer?"),
                          content: Text(
                              "You are about to delete this customer forever!"),
                          actions: [
                            TextButton(
                              child: Text("No"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: Text("Yes"),
                              onPressed: () {
                                var result = context
                                    .read<FirebaseCloudFirestoreService>()
                                    .deleteCustomer(widget._id);

                                if (result != null) {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          CustomersScreen.ROUTE));
                                }
                              },
                            )
                          ],
                        );
                      },
                    );
                  })
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  onSaved: (value) => _newCustomer.name = value.trim(),
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid customer name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Customer Name",
                  ),
                ),
                TextFormField(
                  onSaved: (value) => _newCustomer.description = value.trim(),
                  controller: _descriptionController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid customer description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                  onFieldSubmitted: (value) {
                    value = value.trim();
                  },
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        _newCustomer.id = _oldCustomer.id;
                        bool validationResult =
                            _formKey.currentState.validate();
                        if (validationResult) {
                          print("Form valid");
                        }
                        DocumentReference docRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .updateCustomer(_newCustomer);

                        if (docRef == null) {
                          print("Error updating customer");
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Update"),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
