import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/account_model.dart';
import 'package:mini_invoicer_client/core/models/address_model.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/core/models/pricing_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/inventory_type_customer_data.dart';
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

  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalCodeController = TextEditingController();

  Customer _customer = Customer();
  Address _address = Address();
  Account _account = Account(balance: 0.0, lastUpdated: DateTime.now());
  Inventory _inventory = Inventory(inventoryTypeId: inventoryTypeCustomerId);

  @override
  Widget build(BuildContext context) {
    Stream<List<PricingType>> _pricingTypesStream =
        context.watch<FirebaseCloudFirestoreService>().streamPricingTypes();
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
            TextFormField(
              controller: _buildingController,
              decoration: InputDecoration(
                labelText: "Building",
              ),
              onFieldSubmitted: (value) {
                value = value.trim();
              },
            ),
            TextFormField(
              controller: _streetController,
              decoration: InputDecoration(
                labelText: "Street",
              ),
              onFieldSubmitted: (value) {
                value = value.trim();
              },
            ),
            TextFormField(
              controller: _areaController,
              decoration: InputDecoration(
                labelText: "Area",
              ),
              onFieldSubmitted: (value) {
                value = value.trim();
              },
            ),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "City",
              ),
              onFieldSubmitted: (value) {
                value = value.trim();
              },
            ),
            TextFormField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: "Country",
              ),
              onFieldSubmitted: (value) {
                value = value.trim();
              },
            ),
            TextFormField(
              controller: _postalCodeController,
              decoration: InputDecoration(
                labelText: "Postal Code",
              ),
              onFieldSubmitted: (value) {
                value = value.trim();
              },
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

                  var _pricingTypes = snapshot.data;
                  return DropdownButtonFormField(
                      onSaved: (value) => _customer.pricingTypeId = value,
                      onChanged: (value) => _customer.pricingTypeId = value,
                      decoration: InputDecoration(
                        labelText: "Pricing Type",
                      ),
                      items: _pricingTypes
                          .map((pricingType) => DropdownMenuItem(
                              value: pricingType.id,
                              child: Text("${pricingType.title}")))
                          .toList());
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

                    // customer object
                    _customer.name = _nameController.text.trim();
                    _customer.description = _descriptionController.text.trim();

                    // address object
                    _address.street = _streetController.text.trim();
                    _address.building = _buildingController.text.trim();
                    _address.area = _areaController.text.trim();
                    _address.city = _cityController.text.trim();
                    _address.country = _countryController.text.trim();
                    _address.postalCode = _postalCodeController.text.trim();

                    DocumentReference addressDocRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addAddress(_address);

                    if (addressDocRef == null) {
                      print("Error adding address");
                    } else {
                      _customer.addressId = addressDocRef.id;
                      DocumentReference docRef = await context
                          .read<FirebaseCloudFirestoreService>()
                          .addCustomer(_customer);
                      _customer.id = docRef.id;
                      if (docRef == null) {
                        print("Error adding employee");
                      } else {
                        _account.ownerId = _customer.id;
                        _account.title = _customer.name + " account";
                        _account.lastUpdated = DateTime.now();

                        _inventory.ownerId = _customer.id;
                        _inventory.title = _customer.name + " inventory";
                        _inventory.lastUpdated = DateTime.now();

                        DocumentReference accountDocRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .addAccount(_account);

                        _customer.accountId = accountDocRef.id;

                        DocumentReference inventoryDocRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .addInventory(_inventory);

                        _customer.inventoryId = inventoryDocRef.id;

                        await context
                            .read<FirebaseCloudFirestoreService>()
                            .updateCustomer(_customer);
                        Navigator.of(context).pop();
                      }
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
