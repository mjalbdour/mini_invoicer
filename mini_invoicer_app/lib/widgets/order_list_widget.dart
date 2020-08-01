import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/widgets/order_tile_widget.dart';

class OrderListWidget extends StatefulWidget {
  final Customer customer;
  const OrderListWidget({Key key, @required this.customer}) : super(key: key);

  @override
  _OrderListWidgetState createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("customers/${widget.customer.id}/orders")
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
                    child: Text("no orders yet"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderTileWidget(
                        customer: widget.customer,
                        order: Order.fromMap(
                            snapshot.data.documents[index].data,
                            snapshot.data.documents[index].documentID),
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                  );
        }
      },
    );
  }
}
