import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';

class InvoiceCreateEditScreen extends StatefulWidget {
  final Invoice invoice;
  final Order order;
  final Customer customer;
  InvoiceCreateEditScreen(
      {@required this.invoice, @required this.order, @required this.customer});
  @override
  _InvoiceCreateEditScreenState createState() =>
      _InvoiceCreateEditScreenState();
}

class _InvoiceCreateEditScreenState extends State<InvoiceCreateEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("new invoice"),
      ),
      body: Form(
          child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            enabled: false,
            decoration: InputDecoration(labelText: "customer name"),
            initialValue: widget.customer.name,
          ),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(labelText: "Date"),
            initialValue: DateTime.now().toString(),
          ),
        ],
      )),
    );
  }
}
