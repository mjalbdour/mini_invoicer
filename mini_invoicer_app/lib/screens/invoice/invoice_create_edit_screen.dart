import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/invoice_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/models/product_model.dart';

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

  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    widget.invoice.totalValue = 0.0;
    widget.invoice.number = 0;
    widget.invoice.selectedProducts = <Product>[];
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
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
                decoration: InputDecoration(labelText: "customer name"),
                readOnly: true,
                initialValue: widget.customer.name,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Date DD/MM/YYY"),
                readOnly: true,
                initialValue:
                    "${currentDate.day}/${currentDate.month}/${currentDate.year}",
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "invoice number"),
                readOnly: true,
                initialValue: "${widget.invoice.number}",
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("products").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    default:
                      _products = snapshot.data.documents
                          .map((doc) =>
                              Product.fromMap(doc.data, doc.documentID))
                          .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(_products[index].name),
                              Row(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          _products[index]
                                              .decreaseOrderAmount();
                                        });
                                      },
                                      child: Icon(Icons.remove)),
                                  Text((_products[index].orderAmount)
                                      .toString()),
                                  FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          _products[index]
                                              .increaseOrderAmount();
                                        });
                                      },
                                      child: Icon(Icons.add)),
                                ],
                              )
                            ],
                          );
                        },
                        itemCount: snapshot.data.documents.length,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total"),
                  Text(
                    widget.invoice.totalValue.toString(),
                    style: TextStyle(fontSize: 32.0),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
