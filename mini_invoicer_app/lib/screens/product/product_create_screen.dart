import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';

class ProductCreateScreen extends StatefulWidget {
  static const String title = "create product";
  static const String route = "${ProductListScreen.route}/create";

  @override
  _ProductCreateScreenState createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductCreateScreen.title),
      ),
      body: Center(
        child: Text("create product data entry form"),
      ),
    );
  }
}
