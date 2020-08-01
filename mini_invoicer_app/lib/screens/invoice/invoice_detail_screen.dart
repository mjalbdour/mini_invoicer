import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final Invoice invoice;
  final Order order;
  final Customer customer;
  InvoiceDetailScreen(
      {@required this.invoice, @required this.customer, @required this.order});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(invoice.number.toString()),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(invoice.number.toString()),
          Text(invoice.date.toString()),
          // ...invoice.selectedProducts.entries.map((e) => Text("$e")).toList(),
          Text(invoice.edited.toString()),
          Text(invoice.printCount.toString()),
          Text(invoice.totalValue.toString()),
        ],
      ),
    );
  }
}
