import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/employee/employee_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/employee/employee_screen.dart';
import "package:provider/provider.dart";

class EmployeesScreen extends StatelessWidget {
  static const String ROUTE = "/employees";

  @override
  Widget build(BuildContext context) {
    final _employeesStream =
        context.watch<FirebaseCloudFirestoreService>().streamEmployees();
    return Scaffold(
      appBar: AppBar(
        title: Text("Employees"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(EmployeeAddScreen.ROUTE)),
        ],
      ),
      body: StreamBuilder<List<Employee>>(
        initialData: [],
        stream: _employeesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Oops! Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var _employees = snapshot.data;
          if (_employees.isEmpty) {
            return Center(
              child: Text("No employees found"),
            );
          }

          return ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          EmployeeScreen(_employees[index].id))),
                  title: Text("${_employees[index].name}"),
                  subtitle: Text("${_employees[index].employeeType}"),
                );
              });
        },
      ),
    );
  }
}
