import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Future _productList;

  void _updateProductList() {
    setState(() {
      _productList = DatabaseHelper.instance.getProductList();
    });
  }

  void initState() {
    super.initState();
    _updateProductList();
  }

  Widget _buildProduct(Product product) {
    return ListTile(
      onTap: () {
        /* TODO: Implement nav push to product_detail_screen */
      },
      title: Text(product.name),
      subtitle: Text("Row of 3 prices" /* TODO: Implement Row of prices */),
      trailing: Text(product.brand),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: FutureBuilder(
          future: _productList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildProduct(snapshot.data[index]);
              },
            );
          }),
    );
  }
}
