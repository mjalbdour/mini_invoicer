import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/product/product_detail_screen.dart';

class ProductEditScreen extends StatefulWidget {
  static const String route = "${ProductDetailScreen.route}/edit";
  String title;

  ProductEditScreen({
    this.title = "some product",
  });

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit product form + red delete button"),
      ),
    );
  }
}
