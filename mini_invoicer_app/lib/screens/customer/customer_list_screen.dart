import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/customer/customer_create_screen.dart';

class CustomerListScreen extends StatefulWidget {
  static const String title = "customers";
  static const String route = "/$title";

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add Customer
          Navigator.pushNamed(context, CustomerCreateScreen.route);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(CustomerListScreen.title),
      ),
      body: Center(
        child: Text("when customer list is empty, this text is shown"),
      ),
    );
  }
}
