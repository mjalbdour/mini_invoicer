import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/screens/invoice/invoice_create_edit_screen.dart';
import 'package:mini_invoicer_app/screens/invoice/invoice_list_screen.dart';

class OrderCreateEditScreen extends StatefulWidget {
  final Customer customer;
  final Order order;
  OrderCreateEditScreen({@required this.order, @required this.customer});
  @override
  _OrderCreateEditScreenState createState() => _OrderCreateEditScreenState();
}

class _OrderCreateEditScreenState extends State<OrderCreateEditScreen> {
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
                  invoice: Invoice(),
                  order: widget.order,
                  customer: widget.customer),
            ),
          );
        },
        child: Icon(Icons.note_add),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(
                "customers/${widget.customer.id}/orders/${widget.order.id}/invoices")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            default:
              print(snapshot.data.documents);
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return InvoiceTile(
                    invoice: Invoice.fromMap(
                        snapshot.data.documents[index].data,
                        snapshot.data.documents[index].documentID),
                  );
                },
                itemCount: snapshot.data.documents.length,
              );
          }
        },
      ),
    );
  }
}
