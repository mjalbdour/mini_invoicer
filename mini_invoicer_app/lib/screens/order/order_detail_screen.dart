import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/order_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  OrderDetailScreen({@required this.order});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.id),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(widget.order.id),
          Text(widget.order.totalValue.toString()),
          // StreamBuilder<QuerySnapshot>(
          //     stream:,
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return Center(
          //             child: CircularProgressIndicator(),
          //           );

          //         default:
          //           return ListView.builder(
          //             shrinkWrap: true,
          //             itemBuilder: (BuildContext context, int index) {
          //               print(snapshot.data.documents[index].data);
          //               return InvoiceTile(
          //                 invoice: Invoice.fromMap(
          //                     snapshot.data.documents[index].data,
          //                     snapshot.data.documents[index].documentID),
          //               );
          //             },
          //             itemCount: snapshot.data.documents.length,
          //           );
          //       }
          //     }),
        ],
      ),
    );
  }
}
