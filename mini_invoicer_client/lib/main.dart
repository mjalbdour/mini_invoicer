import 'package:flutter/material.dart';

void main() => runApp(MiniInvoicer());

class MiniInvoicer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mini Invoicer",
      home: Scaffold(
        body: Center(
          child: Text("Mini Invoicer"),
        ),
      ),
    );
  }
}
