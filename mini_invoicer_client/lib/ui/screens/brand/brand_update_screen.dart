import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/countries_data.dart';
import 'package:mini_invoicer_client/ui/screens/brand/brands_screen.dart';
import 'package:provider/provider.dart';

class BrandUpdateScreen extends StatefulWidget {
  final String _id;
  BrandUpdateScreen(this._id);

  @override
  _BrandUpdateScreenState createState() => _BrandUpdateScreenState();
}

class _BrandUpdateScreenState extends State<BrandUpdateScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Brand _oldBrand = Brand();
  Brand _newBrand = Brand();

  @override
  Widget build(BuildContext context) {
    Stream<Brand> _brandStream =
        context.watch<FirebaseCloudFirestoreService>().streamBrand(widget._id);

    return StreamBuilder<Brand>(
      initialData: Brand(),
      stream: _brandStream,
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

        _oldBrand = snapshot.data;
        _nameController.text = _oldBrand.name;
        _descriptionController.text = _oldBrand.description;

        return Scaffold(
          appBar: AppBar(
            title: Text("Update ${_oldBrand.name}"),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    showDialog<bool>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete this brand?"),
                          content: Text(
                              "You are about to delete this brand forever!"),
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
                                    .deleteBrand(widget._id);

                                if (result != null) {
                                  Navigator.popUntil(context,
                                      ModalRoute.withName(BrandsScreen.ROUTE));
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
                  onSaved: (value) => _newBrand.name = value.trim(),
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid brand name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Brand Name",
                  ),
                ),
                TextFormField(
                  onSaved: (value) => _newBrand.description = value.trim(),
                  controller: _descriptionController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid brand description";
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
                DropdownButtonFormField<String>(
                  value: _oldBrand.country ?? countries[111],
                  onChanged: (value) => _newBrand.country = value,
                  onSaved: (value) => _newBrand.country = value,
                  decoration: InputDecoration(labelText: "Country"),
                  items: countries
                      .map(
                        (country) => DropdownMenuItem(
                          child: Text("$country"),
                          value: country,
                        ),
                      )
                      .toList(),
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        _newBrand.id = _oldBrand.id;
                        bool validationResult =
                            _formKey.currentState.validate();
                        if (validationResult) {
                          print("Form valid");
                        }
                        DocumentReference docRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .updateBrand(_newBrand);

                        if (docRef == null) {
                          print("Error updating brand");
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
