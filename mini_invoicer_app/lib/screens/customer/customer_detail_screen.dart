import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/screens/customer/customer_create_edit_screen.dart';
import 'package:mini_invoicer_app/screens/order/order_create_edit_screen.dart';
import 'package:mini_invoicer_app/screens/order/order_list_screen.dart';

class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;

  CustomerDetailScreen({@required this.customer});

  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.customer.name}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CustomerCreateEditScreen(customer: widget.customer)));
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderCreateEditScreen(
                order: Order(),
                customer: widget.customer,
              ),
            ),
          );
        },
        child: Icon(Icons.library_add),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(widget.customer.name),
          Text(widget.customer.address["street"]),
          Text(widget.customer.address["buildingNumber"]),
          Text(widget.customer.address["area"]),
          Text(widget.customer.address["city"]),
          Text(widget.customer.address["postalCode"]),
          Text(widget.customer.address["country"]),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("customers/${widget.customer.id}/orders")
                .snapshots(),
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
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderTile(
                        order: Order.fromMap(
                            snapshot.data.documents[index].data,
                            snapshot.data.documents[index].documentID),
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
