import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/widgets/invoice_list_widget.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  final Customer customer;
  OrderDetailScreen({@required this.order, @required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(order.id),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(order.id),
          Text(order.totalValue.toString()),
          InvoiceListWidget(customer: customer, order: order),
        ],
      ),
    );
  }
}
