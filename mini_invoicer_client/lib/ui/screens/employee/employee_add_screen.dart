import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/account_model.dart';
import 'package:mini_invoicer_client/core/models/address_model.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/core/models/inventory_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/employee_types_data.dart';
import 'package:mini_invoicer_client/ui/constants/vendor_id_data.dart';
import "package:provider/provider.dart";

class EmployeeAddScreen extends StatefulWidget {
  static const String ROUTE = "/employees/add";

  @override
  _EmployeeAddScreenState createState() => _EmployeeAddScreenState();
}

class _EmployeeAddScreenState extends State<EmployeeAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalCodeController = TextEditingController();

  Employee _employee = Employee(vendorId: vendorId);
  Address _address = Address();
  Account _account = Account(balance: 0.0, lastUpdated: DateTime.now());

  @override
  Widget build(BuildContext context) {
    Stream<List<Inventory>> _inventoriesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInventories();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
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
                labelText: "Full Name",
              ),
            ),
            DropdownButtonFormField<String>(
                value: _employee.employeeType,
                onSaved: (value) => _employee.employeeType = value,
                onChanged: (value) => _employee.employeeType = value,
                decoration: InputDecoration(labelText: "Employee Type"),
                items: employeeTypes
                    .map(
                      (employeeType) => DropdownMenuItem(
                        child: Text("$employeeType"),
                        value: employeeType,
                      ),
                    )
                    .toList()),
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
                      value: _employee.inventoryId,
                      onSaved: (value) => _employee.inventoryId = value,
                      onChanged: (value) => _employee.inventoryId = value,
                      decoration: InputDecoration(labelText: "Inventory"),
                      items: _inventories
                          .map((inventory) => DropdownMenuItem<String>(
                              value: inventory.id,
                              child: Text("${inventory.title}")))
                          .toList());
                }),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                "Address",
                style: TextStyle(fontSize: 24.0, color: Colors.black87),
              ),
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
              controller: _buildingController,
              decoration: InputDecoration(
                labelText: "Building",
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
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _employee.name = _nameController.text.trim();

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
                      _employee.addressId = addressDocRef.id;
                      DocumentReference docRef = await context
                          .read<FirebaseCloudFirestoreService>()
                          .addEmployee(_employee);
                      _employee.id = docRef.id;
                      if (docRef == null) {
                        print("Error adding employee");
                      } else {
                        _account.ownerId = _employee.id;
                        _account.title = _employee.name + " account";
                        DocumentReference accountDocRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .addAccount(_account);
                        _employee.accountId = accountDocRef.id;
                        await context
                            .read<FirebaseCloudFirestoreService>()
                            .updateEmployee(_employee);
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
