import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/home.dart';

void main() => runApp(MiniInvoicer());

class MiniInvoicer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mini Invoicer",
      home: HomeScreen(),
    );
  }
}
