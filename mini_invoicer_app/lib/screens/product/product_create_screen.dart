import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/product_model.dart';

class ProductCreateEditScreen extends StatefulWidget {
  final Product product;
  ProductCreateEditScreen({this.product});

  @override
  _ProductCreateEditScreenState createState() =>
      _ProductCreateEditScreenState();
}

class _ProductCreateEditScreenState extends State<ProductCreateEditScreen> {
  var _productFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _originalNameController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _packagingMaterialController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _packageQuantityController = TextEditingController();
  TextEditingController _boxQuantityController = TextEditingController();
  TextEditingController _unitWeightController = TextEditingController();
  TextEditingController _packageWeightController = TextEditingController();
  TextEditingController _boxWeightController = TextEditingController();
  TextEditingController _unitQuantityController = TextEditingController();
  TextEditingController _boxPriceCashvanController = TextEditingController();
  TextEditingController _boxPriceCreditController = TextEditingController();
  TextEditingController _boxPriceWholesaleController = TextEditingController();
  TextEditingController _taxController = TextEditingController();
  TextEditingController _discountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product.id != null) {
      // String
      _nameController.text = widget.product.name;
      _originalNameController.text = widget.product.originalName;
      _brandController.text = widget.product.brand;
      _categoryController.text = widget.product.category;
      _ingredientsController.text = widget.product.ingredients;
      _packagingMaterialController.text = widget.product.packagingMaterial;
      _notesController.text = widget.product.notes;

      // int
      _unitQuantityController.text = widget.product.unitQuantity.toString();
      _packageQuantityController.text =
          widget.product.packageQuantity.toString();
      _boxQuantityController.text = widget.product.boxQuantity.toString();

      _unitWeightController.text = widget.product.unitWeight.toString();
      _packageWeightController.text = widget.product.packageWeight.toString();
      _boxWeightController.text = widget.product.boxWeight.toString();

      // double
      _boxPriceCashvanController.text =
          widget.product.boxPriceCashvan.toString();
      _boxPriceCreditController.text = widget.product.boxPriceCredit.toString();

      _boxPriceWholesaleController.text =
          widget.product.boxPriceWholesale.toString();

      _taxController.text = widget.product.tax.toString();
      _discountController.text = widget.product.discount.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _originalNameController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _ingredientsController.dispose();
    _packagingMaterialController.dispose();
    _notesController.dispose();
    _packageQuantityController.dispose();
    _boxQuantityController.dispose();
    _unitWeightController.dispose();
    _packageWeightController.dispose();
    _boxWeightController.dispose();
    _boxPriceCashvanController.dispose();
    _boxPriceCreditController.dispose();
    _boxPriceWholesaleController.dispose();
    _taxController.dispose();
    _discountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.product.name == null
            ? Text("create product")
            : Text("edit ${widget.product.name}"),
      ),
      body: Form(
        key: _productFormKey,
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
              controller: _unitQuantityController,
              decoration:
                  InputDecoration(labelText: "unit quantity - required"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
            TextFormField(
              controller: _packageQuantityController,
              decoration:
                  InputDecoration(labelText: "package quantity - optional"),
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
              controller: _unitWeightController,
              decoration: InputDecoration(labelText: "unit weight - required"),
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
              controller: _boxWeightController,
              decoration: InputDecoration(labelText: "box weight - required"),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),

            // double
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
                    _productFormKey.currentState.reset();
                  },
                  child: Text("reset"),
                ),
                RaisedButton(
                  onPressed: () {
                    // save form values
                    widget.product.name =
                        _nameController.text.trim().toString();
                    widget.product.originalName =
                        _originalNameController.text.trim().toString();
                    widget.product.brand =
                        _brandController.text.trim().toString();
                    widget.product.category =
                        _categoryController.text.trim().toString();
                    widget.product.ingredients =
                        _ingredientsController.text.trim().toString();
                    widget.product.packagingMaterial =
                        _packagingMaterialController.text.trim().toString();
                    widget.product.notes =
                        _notesController.text.trim().toString();

                    widget.product.unitQuantity =
                        int.parse(_packageQuantityController.text.trim());

                    widget.product.packageQuantity =
                        int.parse(_packageQuantityController.text.trim());

                    widget.product.boxQuantity =
                        int.parse(_boxQuantityController.text.trim());

                    widget.product.unitWeight =
                        int.parse(_unitWeightController.text.trim());

                    widget.product.packageWeight =
                        int.parse(_packageWeightController.text.trim());

                    widget.product.boxWeight =
                        int.parse(_boxWeightController.text.trim());

                    widget.product.boxPriceCashvan =
                        double.parse(_boxPriceCashvanController.text.trim());
                    widget.product.boxPriceCredit =
                        double.parse(_boxPriceCreditController.text.trim());

                    widget.product.boxPriceWholesale =
                        double.parse(_boxPriceWholesaleController.text.trim());
                    widget.product.tax =
                        double.parse(_taxController.text.trim());
                    widget.product.discount =
                        double.parse(_discountController.text.trim());

                    var map = Product.toMap(widget.product);
                    // validate
                    if (_productFormKey.currentState.validate()) {
                      try {
                        Firestore.instance
                            .collection("/products")
                            .add(map); // try setdata in collection
                        Navigator.pop(context);
                      } catch (e) {
                        throw e;
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
