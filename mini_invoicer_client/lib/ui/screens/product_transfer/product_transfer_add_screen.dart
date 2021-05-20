import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_model.dart';
import 'package:mini_invoicer_client/core/models/product_transfer_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class ProductTransferAddScreen extends StatefulWidget {
  static const String ROUTE = "/producttransfers/add";

  @override
  _ProductTransferAddScreenState createState() =>
      _ProductTransferAddScreenState();
}

class _ProductTransferAddScreenState extends State<ProductTransferAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  ProductTransfer _productTransfer = ProductTransfer();

  @override
  Widget build(BuildContext context) {
    Stream<List<Product>> _productsStream =
        context.watch<FirebaseCloudFirestoreService>().streamProducts();

    Stream<List<Inventory>> _inventoriesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventories();

    Stream<List<ProductTransferType>> _productTransferTypesStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamProductTransferTypes();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Transfer"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          children: [
            /*** Product ***/
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
                  return DropdownButtonFormField(
                    onSaved: (value) => _productTransfer.productId = value,
                    onChanged: (value) => _productTransfer.productId = value,
                    decoration: InputDecoration(labelText: "Product"),
                    items: _products
                        .map((product) => DropdownMenuItem(
                              value: product.id,
                              child: Text("${product.title}"),
                            ))
                        .toList(),
                  );
                }),
            TextFormField(
              autofocus: true,
              onSaved: (value) {
                value = value.trim();
                _productTransfer.quantity = int.parse(value);
              },
              controller: _quantityController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              decoration: InputDecoration(
                labelText: "Quantity",
              ),
            ),
            TextFormField(
              autofocus: true,
              onSaved: (value) {
                value = value.trim();
                _productTransfer.description = value;
              },
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),

            /*** From Inventory ***/
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
                  return DropdownButtonFormField(
                    onSaved: (value) =>
                        _productTransfer.fromInventoryId = value,
                    onChanged: (value) =>
                        _productTransfer.fromInventoryId = value,
                    decoration: InputDecoration(labelText: "From Inventory"),
                    items: _inventories
                        .map((inventory) => DropdownMenuItem(
                              value: inventory.id,
                              child: Text("${inventory.title}"),
                            ))
                        .toList(),
                  );
                }),

            /*** To Inventory ***/
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
                  return DropdownButtonFormField(
                    onSaved: (value) => _productTransfer.toInventoryId = value,
                    onChanged: (value) =>
                        _productTransfer.toInventoryId = value,
                    decoration: InputDecoration(labelText: "To Inventory"),
                    items: _inventories
                        .map((inventory) => DropdownMenuItem(
                              value: inventory.id,
                              child: Text("${inventory.title}"),
                            ))
                        .toList(),
                  );
                }),

            /*** Product Transfer Type ***/
            StreamBuilder<List<ProductTransferType>>(
                initialData: [],
                stream: _productTransferTypesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                          child: Text("Error loading product transfer types")),
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
                      child: Center(
                          child:
                              Text("Please add product transfer types first")),
                    );
                  }

                  var _productTransferTypes = snapshot.data;
                  return DropdownButtonFormField(
                    onSaved: (value) =>
                        _productTransfer.productTransferTypeId = value,
                    onChanged: (value) =>
                        _productTransfer.productTransferTypeId = value,
                    decoration:
                        InputDecoration(labelText: "Product Transfer Type"),
                    items: _productTransferTypes
                        .map((productTransferType) => DropdownMenuItem(
                              value: productTransferType.id,
                              child: Text("${productTransferType.title}"),
                            ))
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
                    _productTransfer.timestamp = DateTime.now();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addProductTransfer(_productTransfer);

                    if (docRef == null) {
                      print("Error adding inventory type");
                    } else {
                      _productTransfer.id = docRef.id;
                      _productTransfer.sourceProductTransferId = docRef.id;
                      await context
                          .read<FirebaseCloudFirestoreService>()
                          .updateProductTransfer(_productTransfer);
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
