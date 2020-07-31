import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/order_model.dart';

class OrderListScreen extends StatefulWidget {
  static const String title = "orders";
  static const String route = "/$title";
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final orders = Firestore.instance.collectionGroup("orders");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(OrderListScreen.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: orders.getDocuments().then((value) => value).asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.error),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            default:
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return OrderTile(
                    order: Order.fromMap(snapshot.data.documents[index].data,
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

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({@required this.order});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(order.totalValue.toString()),
      subtitle: Text(order.date.toString()),
    );
  }
}
