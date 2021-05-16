import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  static const String ROUTE = "/products/create";

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  Product _product = Product();

  @override
  Widget build(BuildContext context) {
    final _brandsStream =
        context.watch<FirebaseCloudFirestoreService>().streamBrands();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
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
                labelText: "Product Name",
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
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: "Weight (g)",
              ),
              keyboardType: TextInputType.number,
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

                return DropdownButtonFormField(
                  value: _product.brandId,
                  onChanged: (value) => _product.brandId = value,
                  decoration: InputDecoration(labelText: "Brand"),
                  items: snapshot.data
                      .map((brand) => DropdownMenuItem(
                            child: Text("${brand.title}"),
                            value: brand.id,
                          ))
                      .toList(),
                );
              },
            ),
            DropdownButtonFormField<bool>(
                value: _product.refrigerated,
                onChanged: (value) => _product.refrigerated = value,
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
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _product.name = _nameController.text.trim();
                    _product.description = _descriptionController.text.trim();
                    _product.weight = int.parse(_weightController.text.trim());
                    print(_product.name);
                    print(_product.description);
                    print(_product.weight);
                    print(_product.brandId);
                    print(_product.refrigerated);

                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addProduct(_product);

                    if (docRef == null) {
                      print("Error adding product");
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