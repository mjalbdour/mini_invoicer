import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/screens/customer/customer_create_edit_screen.dart';
import 'package:mini_invoicer_app/screens/order/order_create_edit_screen.dart';
import 'package:mini_invoicer_app/widgets/order_list_widget.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Customer customer;

  CustomerDetailScreen({@required this.customer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${customer.name}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CustomerCreateEditScreen(customer: customer)));
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderCreateEditScreen(
                order: Order(),
                customer: customer,
              ),
            ),
          );
        },
        child: Icon(Icons.library_add),
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
          OrderListWidget(
            customer: customer,
          ),
        ],
      ),
    );
  }
}
