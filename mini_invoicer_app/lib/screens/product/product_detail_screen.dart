import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/screens/product/product_create_screen.dart';

class ProductDetailScreen extends StatefulWidget {
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
          widget.product.packagingMaterial,
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
          Text(widget.product.packagingMaterial),
          Text(widget.product.notes),
          Text(widget.product.unitQuantity.toString()),
          Text(widget.product.packageQuantity.toString()),
          Text(widget.product.boxQuantity.toString()),
          Text(widget.product.unitWeight.toString()),
          Text(widget.product.packageWeight.toString()),
          Text(widget.product.boxWeight.toString()),
          Text(widget.product.boxPriceCashvan.toString()),
          Text(widget.product.boxPriceCredit.toString()),
          Text(widget.product.boxPriceWholesale.toString()),
          Text(widget.product.tax.toString()),
          Text(widget.product.discount.toString()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProductCreateEditScreen(product: widget.product)));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
