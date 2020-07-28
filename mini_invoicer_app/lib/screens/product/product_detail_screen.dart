import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/screens/product/product_edit_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String route = "${ProductListScreen.route}/product";
  final Product product;
  ProductDetailScreen({
    this.product,
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
          widget.product.name,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(widget.product.name),
          Text(widget.product.originalName),
          Text(widget.product.brand),
          Text(widget.product.category),
          Text(widget.product.ingredients),
          Text(widget.product.notes),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProductEditScreen(product: widget.product)));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
