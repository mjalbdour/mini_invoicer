import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';

class InvoiceCreateEditScreen extends StatefulWidget {
  final Invoice invoice;
  final Customer customer;
  final Order order;
  InvoiceCreateEditScreen(
      {@required this.invoice, @required this.order, @required this.customer});
  @override
  _InvoiceCreateEditScreenState createState() =>
      _InvoiceCreateEditScreenState();
}

class _InvoiceCreateEditScreenState extends State<InvoiceCreateEditScreen> {
  final _invoiceKey = GlobalKey<FormState>();

  final CollectionReference productsCollection =
      Firestore.instance.collection("products");

  @override
  void initState() {
    super.initState();
    widget.invoice.totalValue = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("new invoice"),
      ),
      body: Form(
          key: _invoiceKey,
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
              StreamBuilder(
                stream: productsCollection.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TextFormField(
                            onSaved: (value) {},
                            decoration: InputDecoration(
                                labelText: snapshot.data.documents[index]
                                    ["name"]),
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                          );
                        },
                      );
                  }
                },
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _invoiceKey.currentState.save();
                    },
                    child: Text("save"),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
