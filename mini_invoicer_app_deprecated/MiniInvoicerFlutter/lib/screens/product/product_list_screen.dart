import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/screens/product/product_create_edit_screen.dart';
import 'package:mini_invoicer_app/widgets/product_list_widget.dart';

class ProductListScreen extends StatelessWidget {
  static const String title = "products";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductListScreen.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProductCreateEditScreen(product: Product())));
        },
        child: Icon(Icons.add),
      ),
      body: ProductListWidget(collectionPath: "/$title"),
    );
  }
}
