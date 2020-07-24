import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  static const String title = "orders";
  static const String route = "/$title";
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(OrderListScreen.title),
      ),
    );
  }
}
