import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/customer/customer_detail_screen.dart';

class CustomerEditScreen extends StatefulWidget {
  static const String route = "${CustomerDetailScreen.route}/edit";
  String title;

  CustomerEditScreen({
    this.title = "some customer", // for development only
  });

  @override
  _CustomerEditScreenState createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("customer edit form + red delete button"),
      ),
    );
  }
}
