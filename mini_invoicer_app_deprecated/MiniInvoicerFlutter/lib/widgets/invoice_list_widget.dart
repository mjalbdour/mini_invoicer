import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/widgets/invoice_tile_widget.dart';

class InvoiceListWidget extends StatefulWidget {
  final Customer customer;
  final Order order;
  InvoiceListWidget({@required this.customer, @required this.order});
  @override
  _InvoiceListWidgetState createState() => _InvoiceListWidgetState();
}

class _InvoiceListWidgetState extends State<InvoiceListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(
              "/customers/${widget.customer.id}/orders/${widget.order.id}/invoices")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );

          default:
            return snapshot.data.documents.isEmpty
                ? Center(
                    child: Text("no invoices yet"),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return InvoiceTileWidget(
                          customer: widget.customer,
                          order: widget.order,
                          invoice: Invoice.fromMap(
                              snapshot.data.documents[index].data,
                              snapshot.data.documents[index].documentID));
                    },
                    itemCount: snapshot.data.documents.length,
                  );
        }
      },
    );
  }
}
