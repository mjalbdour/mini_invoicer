import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart' as CustomerModel;
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/screens/invoice/invoice_create_edit_screen.dart';
import 'package:mini_invoicer_app/widgets/invoice_list_widget.dart';

class OrderCreateEditScreen extends StatelessWidget {
  final CustomerModel.Customer customer;
  final Order order;
  OrderCreateEditScreen({@required this.order, @required this.customer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("new order"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InvoiceCreateEditScreen(
                  invoice: Invoice(selectedProducts: List()),
                  order: order,
                  customer: customer),
            ),
          );
        },
        child: Icon(Icons.note_add),
      ),
      body: InvoiceListWidget(customer: customer, order: order),
    );
  }
}
