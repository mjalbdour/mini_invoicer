import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
// import 'package:mini_invoicer_client/ui/constants/designations_data.dart';
import "package:provider/provider.dart";

class EmployeeAddScreen extends StatefulWidget {
  static const String ROUTE = "/employees/add";

  @override
  _EmployeeAddScreenState createState() => _EmployeeAddScreenState();
}

class _EmployeeAddScreenState extends State<EmployeeAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Employee _employee = Employee();

  @override
  Widget build(BuildContext context) {
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
            // DropdownButtonFormField<String>(
            //     value: designations[0],
            //     onSaved: (value) => _employee.employeeTypeId = value,
            //     items: designations
            //         .map(
            //           (designation) => DropdownMenuItem(
            //             child: Text("$designation"),
            //             value: designation,
            //           ),
            //         )
            //         .toList()),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _employee.name = _nameController.text.trim();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addEmployee(_employee);

                    if (docRef == null) {
                      print("Error adding employee");
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
