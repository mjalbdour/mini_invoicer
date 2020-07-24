import 'package:flutter/material.dart';

class ReceiptListScreen extends StatefulWidget {
  static const String title = "receipts";
  static const String route = "/$title";
  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ReceiptListScreen.title),
      ),
    );
  }
}
