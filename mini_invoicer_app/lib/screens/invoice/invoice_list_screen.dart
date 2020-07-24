import 'package:flutter/material.dart';

class InvoiceListScreen extends StatefulWidget {
  static const String title = "invoices";
  static const String route = "/$title";

  @override
  _InvoiceListScreenState createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(InvoiceListScreen.title),
      ),
    );
  }
}
