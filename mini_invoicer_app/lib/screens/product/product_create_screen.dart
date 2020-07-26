import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';

class ProductCreateScreen extends StatefulWidget {
  static const String title = "create product";
  static const String route = "${ProductListScreen.route}/create";

  @override
  _ProductCreateScreenState createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  var _productCreateFormKey = GlobalKey<FormState>();

  String _name;
  double _price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductCreateScreen.title),
      ),
      body: Form(
        key: _productCreateFormKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "name"),
              onSaved: (input) => _name = input.trim(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "price"),
              onSaved: (input) => _price = double.parse(input.trim()),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    // show message dialog yes no then
                    _productCreateFormKey.currentState.reset();
                  },
                  child: Text("reset"),
                ),
                RaisedButton(
                  onPressed: () {
                    // save form values
                    _productCreateFormKey.currentState.save();
                    // validate
                    if (_productCreateFormKey.currentState.validate()) {
                      try {
                        Firestore.instance
                            .collection("/products")
                            .document()
                            .setData({"name": _name, "price": _price});
                        // try setdata in collection
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text("create"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
