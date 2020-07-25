import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/product/product_edit_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String route = "${ProductListScreen.route}/product";
  String title;

  ProductDetailScreen({
    this.title = "some product",
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Text("product screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ProductEditScreen.route);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
