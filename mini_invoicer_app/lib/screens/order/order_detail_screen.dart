import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  OrderDetailScreen({@required this.order});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(order.id),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[],
      ),
    );
  }
}
