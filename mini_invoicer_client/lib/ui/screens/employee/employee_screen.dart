import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/employee/employee_update_screen.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatelessWidget {
  final String _id;
  EmployeeScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<Employee> _employeeStream =
        context.watch<FirebaseCloudFirestoreService>().streamEmployee(_id);
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

        Employee _employee = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text(
                "${_employee.name}"),
            actions: [
              IconButton(
                icon: (Icon(Icons.edit)),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EmployeeUpdateScreen(_id),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text(
                  "${_employee.name}"),
              Text("Temp// ${_employee.accountId}"),
            ],
          ),
        );
      },
    );
  }
}
