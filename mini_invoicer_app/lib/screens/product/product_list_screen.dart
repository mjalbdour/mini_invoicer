import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/product/product_create_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const String title = "products";
  static const String route = "/$title";

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductListScreen.title),
      ),
      body: Center(
        child: Text("product list"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,  ProductCreateScreen.route);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
