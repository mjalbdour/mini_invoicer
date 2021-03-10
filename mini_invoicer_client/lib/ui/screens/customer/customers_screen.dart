import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/customer/customer_screen.dart';
import "package:provider/provider.dart";

class CustomersScreen extends StatelessWidget {
  static const String ROUTE = "/customers";
  @override
  Widget build(BuildContext context) {
    final _customersStream =
        context.watch<FirebaseCloudFirestoreService>().streamCustomers();
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Customer>>(
        initialData: [],
        stream: _customersStream,
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

          var _customers = snapshot.data;
          if (_customers.isEmpty) {
            return Center(
              child: Text("No customers found"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _customers.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CustomerScreen(_customers[index].id))),
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
                      Text("${_customers[index].name}"),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Temp// addressId: ${_customers[index].addressId}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
