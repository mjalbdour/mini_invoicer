import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/customer/customer_edit_screen.dart';
import 'package:mini_invoicer_app/screens/customer/customer_list_screen.dart';

class CustomerDetailScreen extends StatefulWidget {
  static const String route = "${CustomerListScreen.route}/customer";
  String title;

  CustomerDetailScreen({
    this.title = "some customer",
  });

  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CustomerEditScreen.route);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
