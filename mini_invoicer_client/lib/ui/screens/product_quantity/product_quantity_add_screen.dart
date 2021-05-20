import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/core/models/product_quantity_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class ProductQuantityAddScreen extends StatefulWidget {
  static const String ROUTE = "/productquantities/add";

  @override
  _ProductQuantityAddScreenState createState() =>
      _ProductQuantityAddScreenState();
}

class _ProductQuantityAddScreenState extends State<ProductQuantityAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();

  ProductQuantity _productQuantity = ProductQuantity();

  @override
  Widget build(BuildContext context) {
    Stream<List<Product>> _productsStream =
        context.watch<FirebaseCloudFirestoreService>().streamProducts();
    Stream<List<Inventory>> _inventoriesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventories();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add ProductQuantity"),
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
              keyboardType: TextInputType.number,
              onSaved: (value) {
                value = value.trim();
                _productQuantity.quantity = int.parse(value);
              },
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: "Quantity",
              ),
            ),

            /*** Products ***/
            StreamBuilder<List<Product>>(
                initialData: [],
                stream: _productsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text("Error loading products")),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text("Please add products first")),
                    );
                  }

                  var _products = snapshot.data;
                  return DropdownButtonFormField<String>(
                    onSaved: (value) => _productQuantity.productId = value,
                    onChanged: (value) => _productQuantity.productId = value,
                    decoration: InputDecoration(labelText: "Product"),
                    items: _products
                        .map(
                          (product) => DropdownMenuItem<String>(
                            value: product.id,
                            child: Text("${product.title}"),
                          ),
                        )
                        .toList(),
                  );
                }),

            /*** Inventories ***/
            StreamBuilder<List<Inventory>>(
                initialData: [],
                stream: _inventoriesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text("Error loading inventories")),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          Center(child: Text("Please add inventories first")),
                    );
                  }

                  var _inventories = snapshot.data;
                  return DropdownButtonFormField<String>(
                    onSaved: (value) => _productQuantity.inventoryId = value,
                    onChanged: (value) => _productQuantity.inventoryId = value,
                    decoration: InputDecoration(labelText: "Inventory"),
                    items: _inventories
                        .map(
                          (inventory) => DropdownMenuItem<String>(
                            value: inventory.id,
                            child: Text("${inventory.title}"),
                          ),
                        )
                        .toList(),
                  );
                }),
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
                        .addProductQuantity(_productQuantity);

                    if (docRef == null) {
                      print("Error adding product quantity");
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
