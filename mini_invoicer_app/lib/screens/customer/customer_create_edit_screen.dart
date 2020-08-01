import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';

class CustomerCreateEditScreen extends StatefulWidget {
  final Customer customer;

  CustomerCreateEditScreen({@required this.customer});

  @override
  _CustomerCreateEditScreenState createState() =>
      _CustomerCreateEditScreenState();
}

class _CustomerCreateEditScreenState extends State<CustomerCreateEditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildingNumberController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _typeController = TextEditingController();

  final _customerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.customer.id != null) {
      _nameController.text = widget.customer.name;
      _streetController.text = widget.customer.address["street"];
      _buildingNumberController.text =
          widget.customer.address["buildingNumber"];
      _areaController.text = widget.customer.address["area"];
      _postalCodeController.text = widget.customer.address["postalCode"];
      _cityController.text = widget.customer.address["city"];
      _countryController.text = widget.customer.address["country"];
      _typeController.text = widget.customer.type;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _streetController.dispose();
    _buildingNumberController.dispose();
    _areaController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _typeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.customer.id == null
            ? Text("create customer")
            : Text("edit ${widget.customer.name}"),
      ),
      body: Form(
          key: _customerFormKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "name"),
              ),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: "street"),
              ),
              TextFormField(
                controller: _buildingNumberController,
                decoration: InputDecoration(labelText: "building number"),
              ),
              TextFormField(
                controller: _areaController,
                decoration: InputDecoration(labelText: "area"),
              ),
              TextFormField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: "postal code"),
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: "city"),
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: "country"),
              ),

              // TODO: implement radio later, use enum
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: "type"),
              ),

              ButtonBar(
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        _customerFormKey.currentState.reset();
                      },
                      child: Text("reset")),
                  RaisedButton(
                    onPressed: () {
                      widget.customer.name =
                          _nameController.text.trim().toString();
                      widget.customer.address = <String, dynamic>{
                        "street": _streetController.text.trim().toString(),
                        "buildingNumber":
                            _buildingNumberController.text.trim().toString(),
                        "area": _areaController.text.trim().toString(),
                        "city": _cityController.text.trim().toString(),
                        "postalCode":
                            _postalCodeController.text.trim().toString(),
                        "country": _countryController.text.trim().toString()
                      };
                      widget.customer.type =
                          _typeController.text.trim().toString();

                      final map = Customer.toMap(widget.customer);

                      if (_customerFormKey.currentState.validate()) {
                        if (widget.customer.id != null) {
                          try {
                            Firestore.instance
                                .collection("/customers")
                                .document("${widget.customer.id}")
                                .updateData(map);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          } catch (e) {
                            print(e);
                          }
                        } else if (widget.customer.id == null) {
                          try {
                            Firestore.instance
                                .collection("/customers")
                                .add(map);
                            Navigator.of(context).pop();
                          } catch (e) {
                            print(e);
                          }
                        }
                      }
                    },
                    child: widget.customer.id == null
                        ? Text("create")
                        : Text("edit"),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
