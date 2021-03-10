import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
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
      ),
      body: StreamBuilder<List<Employee>>(
        initialData: [],
        stream: _employeesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _employees.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EmployeeScreen(_employees[index].id))),
                child: Container(
                  height: 100.0,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        Text(
                            "${_employees[index].name['designation']}. ${_employees[index].name['last']}"),
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${_employees[index].id}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
