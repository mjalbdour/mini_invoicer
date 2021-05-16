import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
// import 'package:mini_invoicer_client/ui/constants/designations_data.dart';
import 'package:mini_invoicer_client/ui/screens/employee/employees_screen.dart';
import 'package:provider/provider.dart';

class EmployeeUpdateScreen extends StatefulWidget {
  final String _id;
  EmployeeUpdateScreen(this._id);

  @override
  _EmployeeUpdateScreenState createState() => _EmployeeUpdateScreenState();
}

class _EmployeeUpdateScreenState extends State<EmployeeUpdateScreen> {
  var _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Employee _oldEmployee = Employee();
  Employee _newEmployee = Employee();

  @override
  Widget build(BuildContext context) {
    Stream<Employee> _employeeStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamEmployee(widget._id);

    return StreamBuilder<Employee>(
      initialData: Employee(),
      stream: _employeeStream,
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

        _oldEmployee = snapshot.data;
        _newEmployee.id = _oldEmployee.id;
        _nameController.text = _oldEmployee.name;

        _newEmployee.name = _oldEmployee.name;

        return Scaffold(
          appBar: AppBar(
            title: Text("Update ${_oldEmployee.name}"),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    showDialog<bool>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete this employee?"),
                          content: Text(
                              "You are about to delete this employee forever!"),
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
                                    .deleteEmployee(widget._id);

                                if (result != null) {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          EmployeesScreen.ROUTE));
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
                  autofocus: true,
                  onSaved: (value) {
                    _newEmployee.name = value.trim();
                  },
                  onFieldSubmitted: (value) {
                    value = value.trim();
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "First Name",
                  ),
                ),
                // DropdownButtonFormField<String>(
                //     value: _oldEmployee.name["designation"],
                //     onChanged: (value) =>
                //         _newEmployee.name["designation"] = value,
                //     onSaved: (value) =>
                //         _newEmployee.name["designation"] = value,
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
                    ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        bool validationResult =
                            _formKey.currentState.validate();
                        if (validationResult) {
                          print("Form valid");
                        }
                        DocumentReference docRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .updateEmployee(_newEmployee);

                        if (docRef == null) {
                          print("Error updating employee");
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
