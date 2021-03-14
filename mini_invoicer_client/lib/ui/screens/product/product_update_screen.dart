import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/product/products_screen.dart';
import 'package:provider/provider.dart';

class ProductUpdateScreen extends StatefulWidget {
  final String _id;
  ProductUpdateScreen(this._id);

  @override
  _ProductUpdateScreenState createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  Product _oldProduct = Product();
  Product _newProduct = Product();

  @override
  Widget build(BuildContext context) {
    Stream<Product> _productStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamProduct(widget._id);
    Stream<List<Brand>> _brandsStream =
        context.watch<FirebaseCloudFirestoreService>().streamBrands();

    return StreamBuilder<Product>(
      initialData: Product(),
      stream: _productStream,
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

        _oldProduct = snapshot.data;
        _nameController.text = _oldProduct.name;
        _descriptionController.text = _oldProduct.description;
        _weightController.text = _oldProduct.weight.toString();

        return Scaffold(
          appBar: AppBar(
            title: Text("Update ${_oldProduct.name}"),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    var decision = showDialog<bool>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete this product?"),
                          content: Text(
                              "Your about to delete this product forever!"),
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
                                    .deleteProduct(widget._id);

                                if (result != null) {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          ProductsScreen.ROUTE));
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
                  onSaved: (value) => _newProduct.name = value.trim(),
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid product name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Product Name",
                  ),
                ),
                TextFormField(
                  onSaved: (value) => _newProduct.description = value.trim(),
                  controller: _descriptionController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid product description";
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
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    if (value.isNotEmpty) {
                      int result = int.parse(value);
                      if (result != null) {
                        _newProduct.weight = result;
                      }
                    } else {
                      _newProduct.weight = 0;
                    }
                  },
                  controller: _weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid product weight in grams (integer only)";
                    }
                    var result;
                    int.tryParse(value, radix: result);
                    if (result != null) {
                      if (result == 0) {
                        return "Please enter a valid product weight in grams (integer only)";
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Weight (g)",
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  onFieldSubmitted: (value) {
                    value = value.trim();
                  },
                ),
                StreamBuilder<List<Brand>>(
                  initialData: [],
                  stream: _brandsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text("Error loading brands ${snapshot.error}"),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data.isEmpty) {
                      return Column(
                        children: [
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(labelText: "Brands"),
                          ),
                          Text("Add brands to use this feature"),
                        ],
                      );
                    }

                    return DropdownButtonFormField<String>(
                      value: _oldProduct.brandId,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please select a brand";
                        }
                        return null;
                      },
                      onChanged: (value) => _newProduct.brandId = value,
                      onSaved: (value) => _newProduct.brandId = value,
                      decoration: InputDecoration(labelText: "Brand"),
                      items: snapshot.data
                          .map((brand) => DropdownMenuItem(
                                child: Text("${brand.name}"),
                                value: brand.id,
                              ))
                          .toList(),
                    );
                  },
                ),
                DropdownButtonFormField<bool>(
                    value: _oldProduct.requiresRefrigeration ?? false,
                    onChanged: (value) =>
                        _newProduct.requiresRefrigeration = value,
                    onSaved: (value) =>
                        _newProduct.requiresRefrigeration = value,
                    decoration:
                        InputDecoration(labelText: "Requires Refrigeration?"),
                    items: [
                      DropdownMenuItem(
                        child: Text("No"),
                        value: false,
                      ),
                      DropdownMenuItem(
                        child: Text("Yes"),
                        value: true,
                      ),
                    ]),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        _newProduct.id = _oldProduct.id;
                        bool validationResult =
                            _formKey.currentState.validate();
                        if (validationResult) {
                          print("Form valid");
                        }
                        DocumentReference docRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .updateProduct(_newProduct);

                        if (docRef == null) {
                          print("Error updating product");
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
