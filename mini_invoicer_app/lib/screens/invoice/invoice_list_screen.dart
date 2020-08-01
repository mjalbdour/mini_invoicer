import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/screens/invoice/invoice_detail_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  static const String title = "invoices";
  static const String route = "/$title";

  @override
  _InvoiceListScreenState createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  final CollectionReference invoices =
      Firestore.instance.collectionGroup(InvoiceListScreen.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(InvoiceListScreen.title),
      ),
      body: StreamBuilder(
          stream: invoices.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                  final Map<String, dynamic> map =
                      snapshot.data.documents[index].data;
                  final String id = snapshot.data.documents[index].documentID;
                  return InvoiceTile(invoice: Invoice.fromMap(map, id));
                });
            }
          }),
    );
  }
}

class InvoiceTile extends StatelessWidget {
  final Invoice invoice;
  InvoiceTile({this.invoice});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(invoice.totalValue.toString()),
        subtitle: Text(invoice.edited.toString()),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InvoiceDetailScreen(invoice: invoice),
            ),
          );
        },
      ),
    );
  }
}
