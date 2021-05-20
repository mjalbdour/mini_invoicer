import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/customer/customer_add_screen.dart';
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
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CustomerAddScreen.ROUTE))
        ],
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

          if (snapshot.data.isEmpty) {
            return Center(
              child: Text("No customers found"),
            );
          }

          var _customers = snapshot.data;

          return ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CustomerScreen(_customers[index].id))),
                  title: Text("${_customers[index].name}"),
                  subtitle: Text("${_customers[index].description}"),
                );
              });
        },
      ),
    );
  }
}
