import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/core/models/employee_model.dart';
import 'package:mini_invoicer_client/core/models/invoice_item_model.dart';
import 'package:mini_invoicer_client/core/models/invoice_model.dart';
import 'package:mini_invoicer_client/core/models/product_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/payment_types_data.dart';
import 'package:provider/provider.dart';

class InvoiceAddScreen extends StatefulWidget {
  static const String ROUTE = "/invoices/add";

  const InvoiceAddScreen({Key key}) : super(key: key);

  @override
  _InvoiceAddScreenState createState() => _InvoiceAddScreenState();
}

class _InvoiceAddScreenState extends State<InvoiceAddScreen> {
  Invoice _invoice = Invoice();
  List<InvoiceItem> _invoiceItems = [];

  @override
  Widget build(BuildContext context) {
    Stream<List<Product>> _productsStream =
        context.watch<FirebaseCloudFirestoreService>().streamProducts();
    Stream<List<Customer>> _customersStream =
        context.watch<FirebaseCloudFirestoreService>().streamCustomers();
    Stream<List<Employee>> _employeeStream =
        context.watch<FirebaseCloudFirestoreService>().streamEmployees();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Invoice"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            "On: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            textAlign: TextAlign.center,
          ),
          /*** Employee ***/
          StreamBuilder<List<Employee>>(
            initialData: [],
            stream: _employeeStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      Center(child: Text("Error loading employees. Go back")),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.data.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text("No employees found. Go back")),
                );
              }

              var _employees = snapshot.data;
              return DropdownButtonFormField<String>(
                onChanged: (value) => _invoice.employeeId = value,
                onSaved: (value) => _invoice.employeeId = value,
                decoration: InputDecoration(labelText: "Employee"),
                items: _employees
                    .map((employee) => DropdownMenuItem(
                          value: employee.id,
                          child: Text("${employee.name}"),
                        ))
                    .toList(),
              );
            },
          ),
          StreamBuilder<List<Customer>>(
            initialData: [],
            stream: _customersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      Center(child: Text("Error loading customers. Go back")),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.data.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text("No customers found. Go back")),
                );
              }

              var _customers = snapshot.data;
              return DropdownButtonFormField<String>(
                onChanged: (value) => _invoice.customerId = value,
                onSaved: (value) => _invoice.customerId = value,
                decoration: InputDecoration(labelText: "Customer"),
                items: _customers
                    .map((customer) => DropdownMenuItem(
                          value: customer.id,
                          child: Text("${customer.name}"),
                        ))
                    .toList(),
              );
            },
          ),

          /*** Products - DYNAMICALLY ADDED ***/
          Divider(),
          Text(
            "Items",
            style: TextStyle(fontSize: 20.0),
          ),
          Row(
            children: [
              Text("Add Item"),
              SizedBox(
                width: 16.0,
              ),
              ElevatedButton(
                onPressed: () => null,
                child: Icon(Icons.add),
              )
            ],
          ),
          StreamBuilder<List<Product>>(
            initialData: [],
            stream: _productsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text("Error loading products. Go back")),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.data.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text("No products found. Go back")),
                );
              }

              var _products = snapshot.data;
              return Column(
                children: [],
              );
            },
          ),
          Divider(),
          /*** Payment Type ***/
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: "Payment Type"),
            onChanged: (value) => _invoice.paymentType = value,
            onSaved: (value) => _invoice.paymentType = value,
            items: PAYMENTTYPES
                .map(
                  (paymentType) => DropdownMenuItem<String>(
                    value: paymentType,
                    child: Text("$paymentType"),
                  ),
                )
                .toList(),
          ),
          Divider(),
          // TODO: Convert to rows later
          Text("Sub Total: #"),
          Text("Discounts: #"),
          Text("Tax Value: #"),
          Text(
            "Total: #",
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}
