import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/customer/customer_list_screen.dart';

class CustomerCreateScreen extends StatefulWidget {
  static const String title = "create customer";
  static const String route = "${CustomerListScreen.route}/create";

  @override
  _CustomerCreateScreenState createState() => _CustomerCreateScreenState();
}

class _CustomerCreateScreenState extends State<CustomerCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomerCreateScreen.title),
      ),
      body: Center(
        child: Text("create customer form"),
      ),
    );
  }
}
