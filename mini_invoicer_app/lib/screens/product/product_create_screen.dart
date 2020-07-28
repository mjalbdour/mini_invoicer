import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';

class ProductCreateScreen extends StatefulWidget {
  static const String title = "create product";
  static const String route = "${ProductListScreen.route}/create";
  @override
  _ProductCreateScreenState createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  var _productCreateFormKey = GlobalKey<FormState>();

  final Product _product = Product();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _originalNameController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _packagingMaterialController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _packageUnitsController = TextEditingController();
  TextEditingController _boxUnitsController = TextEditingController();
  TextEditingController _unitWeightController = TextEditingController();
  TextEditingController _packageWeightController = TextEditingController();
  TextEditingController _boxWeightController = TextEditingController();
  TextEditingController _boxQuantityController = TextEditingController();
  TextEditingController _boxPriceCashvanController = TextEditingController();
  TextEditingController _boxPriceCreditController = TextEditingController();
  TextEditingController _boxPriceWholesaleController = TextEditingController();
  TextEditingController _taxController = TextEditingController();
  TextEditingController _discountController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _originalNameController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
  }

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
            // STRING
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "name"),
            ),
            TextFormField(
              controller: _originalNameController,
              decoration: InputDecoration(labelText: "original name"),
            ),
            TextFormField(
              controller: _brandController,
              decoration: InputDecoration(labelText: "brand"),
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: "category"),
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: "ingredients"),
            ),
            TextFormField(
              controller: _packagingMaterialController,
              decoration: InputDecoration(labelText: "packaging material"),
            ),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(labelText: "notes"),
            ),
            // INT
            TextFormField(
              controller: _boxUnitsController,
              decoration: InputDecoration(labelText: "box units - required"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
            TextFormField(
              controller: _packageUnitsController,
              decoration:
                  InputDecoration(labelText: "package units - optional"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
            TextFormField(
              controller: _unitWeightController,
              decoration: InputDecoration(labelText: "unit weight - required"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),

            // DOUBLE
            TextFormField(
              controller: _boxWeightController,
              decoration: InputDecoration(labelText: "box weight - required"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
            TextFormField(
              controller: _packageWeightController,
              decoration:
                  InputDecoration(labelText: "package weight - optional"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
            TextFormField(
              controller: _boxQuantityController,
              decoration: InputDecoration(labelText: "box quantity - required"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
            TextFormField(
              controller: _boxPriceCashvanController,
              decoration: InputDecoration(labelText: "price - cashvan"),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
            ),
            TextFormField(
              controller: _boxPriceCreditController,
              decoration: InputDecoration(labelText: "price - credit"),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
            ),
            TextFormField(
              controller: _boxPriceWholesaleController,
              decoration: InputDecoration(labelText: "price - wholesale"),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
            ),
            TextFormField(
              controller: _taxController,
              decoration: InputDecoration(labelText: "tax - required"),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
            ),
            TextFormField(
              controller: _discountController,
              decoration: InputDecoration(labelText: "discount - default zero"),
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
                    _product.name = _nameController.text.trim().toString();
                    _product.originalName =
                        _originalNameController.text.trim().toString();
                    _product.brand = _brandController.text.trim().toString();
                    _product.category =
                        _categoryController.text.trim().toString();
                    _product.ingredients =
                        _ingredientsController.text.trim().toString();
                    _product.packagingMaterial =
                        _packagingMaterialController.text.trim().toString();
                    _product.notes = _notesController.text.trim().toString();

                    _product.unitQuantity =
                        int.parse(_packageUnitsController.text.trim());

                    _product.packageQuantity =
                        int.parse(_packageUnitsController.text.trim());

                    _product.boxQuantity =
                        int.parse(_boxUnitsController.text.trim());

                    _product.unitWeight =
                        int.parse(_unitWeightController.text.trim());

                    _product.packageWeight =
                        int.parse(_packageWeightController.text.trim());

                    _product.boxWeight =
                        int.parse(_boxWeightController.text.trim());

                    _product.boxPriceCashvan =
                        double.parse(_boxPriceCashvanController.text.trim());
                    _product.boxPriceCredit =
                        double.parse(_boxPriceCreditController.text.trim());

                    _product.boxPriceWholesale =
                        double.parse(_boxPriceWholesaleController.text.trim());
                    _product.tax = double.parse(_taxController.text.trim());
                    _product.discount =
                        double.parse(_discountController.text.trim());

                    var map = Product.toMap(_product);
                    (_product);
                    (map);
                    // validate
                    if (_productCreateFormKey.currentState.validate()) {
                      try {
                        Firestore.instance
                            .collection("/products")
                            .add(map); // try setdata in collection
                        Navigator.pop(context);
                      } catch (e) {
                        (e);
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
