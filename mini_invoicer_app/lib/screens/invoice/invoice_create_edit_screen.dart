import 'package:cloud_firestore/cloud_firestore.dart';
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
  final CollectionReference products =
      Firestore.instance.collection("products");
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
          StreamBuilder(
              stream: products.snapshots(),
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
                          return ProductCounter(
                              productName:
                                  snapshot.data.documents[index].data["name"]);
                        });
                }
              }),
        ],
      )),
    );
  }
}

class ProductCounter extends StatefulWidget {
  final String productName;

  ProductCounter({@required this.productName});

  @override
  _ProductCounterState createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  int amount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(widget.productName),
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: amount > 0
                  ? () {
                      if (amount > 0) {
                        setState(() {
                          amount--;
                        });
                      }
                    }
                  : null,
              child: Icon(Icons.remove),
            ),
            Text(amount.toString()),
            FlatButton(
              onPressed: () {
                setState(() {
                  amount++;
                });
              },
              child: Icon(Icons.add),
            )
          ],
        )
      ],
    );
  }
}
