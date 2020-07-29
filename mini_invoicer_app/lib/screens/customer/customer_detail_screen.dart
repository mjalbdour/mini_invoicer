import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/screens/customer/customer_create_edit_screen.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Customer customer;

  CustomerDetailScreen({@required this.customer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${customer.name}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CustomerCreateEditScreen(customer: customer)));
        },
        child: Icon(Icons.edit),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(customer.name),
          Text(customer.address["street"]),
          Text(customer.address["buildingNumber"]),
          Text(customer.address["area"]),
          Text(customer.address["city"]),
          Text(customer.address["postalCode"]),
          Text(customer.address["country"]),
          Text(customer.type),
        ],
      ),
    );
  }
}
