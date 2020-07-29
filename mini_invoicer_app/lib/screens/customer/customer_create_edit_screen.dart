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
          child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "name"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "street"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "building number"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "area"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "postal code"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "city"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "country"),
          ),

          // TODO: implement radio later, use enum
          TextFormField(
            decoration: InputDecoration(labelText: "type"),
          ),

          ButtonBar(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child:
                    widget.customer.id == null ? Text("create") : Text("edit"),
              )
            ],
          ),
        ],
      )),
    );
  }
}
