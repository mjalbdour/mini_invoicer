import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/screens/customer/customer_create_edit_screen.dart';
import 'package:mini_invoicer_app/widgets/customer_list_widget.dart';

class CustomerListScreen extends StatelessWidget {
  static const String title = "customers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomerListScreen.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CustomerCreateEditScreen(customer: Customer())));
        },
        child: Icon(Icons.add),
      ),
      body: CustomerListWidget(
        collectionPath: route,
      ),
    );
  }
}
