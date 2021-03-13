import 'package:flutter/material.dart';

class ProductAddScreen extends StatefulWidget {
  static const String ROUTE = "/products/create";

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Product Name",
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () => null,
                  child: Text("Add"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
