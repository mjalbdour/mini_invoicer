import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/screens/invoice/invoice_detail_screen.dart';

class InvoiceTileWidget extends StatelessWidget {
  final Invoice invoice;
  final Customer customer;
  final Order order;
  InvoiceTileWidget(
      {@required this.invoice, @required this.customer, @required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InvoiceDetailScreen(
                  invoice: invoice, customer: customer, order: order)));
        },
        title: Text(invoice.date.toString()),
        subtitle: Text(invoice.totalValue.toString()),
      ),
    );
  }
}
