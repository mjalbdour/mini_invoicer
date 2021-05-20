import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/core/models/currency_model.dart';
import 'package:mini_invoicer_client/core/models/pricing_type_model.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/core/models/product_pricing_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/currencies_data.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  static const String ROUTE = "/products/create";

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  final _salesTaxController = TextEditingController();

  Product _product = Product();
  List<PricingType> _pricingTypes = [];
  List<ProductPricing> _productPricings = [];

  @override
  Widget build(BuildContext context) {
    final _brandsStream =
        context.watch<FirebaseCloudFirestoreService>().streamBrands();
    final _pricingTypesStream =
        context.watch<FirebaseCloudFirestoreService>().streamPricingTypes();

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
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Product Title",
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
                onSaved: (value) => _product.refrigerated = value,
                decoration: InputDecoration(labelText: "Refrigerated?"),
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
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                "Pricings",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            StreamBuilder<List<PricingType>>(
                initialData: [],
                stream: _pricingTypesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text("Error loading pricing types")),
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
                          Center(child: Text("Please add pricing types first")),
                    );
                  }

                  _pricingTypes = snapshot.data;
                  _pricingTypes.forEach((pricingType) {
                    _productPricings.add(ProductPricing(
                        pricingTypeId: pricingType.id,
                        currency: currencies[2].code,
                        price: 0.0));
                  });
                  return Column(
                      children: _pricingTypes
                          .map((pricingType) => TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _productPricings
                                      .firstWhere((productPricing) =>
                                          productPricing.pricingTypeId ==
                                          pricingType.id)
                                      .price = double.parse(value);
                                },
                                onFieldSubmitted: (value) {
                                  value = value.trim();
                                },
                                controller: TextEditingController(),
                                decoration: InputDecoration(
                                  labelText:
                                      "${pricingType.title} - ${currencies[2].code}",
                                ),
                              ))
                          .toList());
                }),
            Divider(),
            Divider(),
            Divider(),
            TextFormField(
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                value = value.trim();
              },
              controller: _salesTaxController,
              decoration: InputDecoration(
                labelText: "Sales Tax %",
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
                    _product.title = _titleController.text.trim();
                    _product.description = _descriptionController.text.trim();
                    _product.weight = int.parse(_weightController.text.trim());
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addProduct(_product);

                    if (docRef == null) {
                      print("Error adding product");
                    } else {
                      _productPricings.forEach((productPricing) {
                        productPricing.productId = docRef.id;
                        productPricing.salesTax =
                            int.parse(_salesTaxController.text.trim());
                      });
                      _productPricings.forEach((productPricing) async {
                        await context
                            .read<FirebaseCloudFirestoreService>()
                            .addProductPricing(productPricing);
                      });
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
