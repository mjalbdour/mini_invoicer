import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/address_model.dart';
import 'package:mini_invoicer_client/core/models/customer_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/customer/customer_update_screen.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatelessWidget {
  final String _id;

  CustomerScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<Customer> _customerStream =
        context.watch<FirebaseCloudFirestoreService>().streamCustomer(_id);

    Stream<Address> _addressStream =
        context.watch<FirebaseCloudFirestoreService>().streamAddress(_id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CustomerUpdateScreen(_id),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          StreamBuilder<Customer>(
            initialData: Customer(),
            stream: _customerStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        Text("Oops! Something went wrong"),
                        IconButton(
                          icon: Icon(Icons.arrow_back_outlined),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              Customer _customer = snapshot.data;
              return Column(
                children: [
                  Text("${_customer.name}"),
                  Text("${_customer.description}"),
                ],
              );
            },
          ),
          StreamBuilder<Address>(
              initialData: Address(),
              stream: _addressStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text("Error loading address")),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Text("Customer doesn't have an address yet.")),
                  );
                }

                var _address = snapshot.data;
                return Column(
                  children: [
                    Text("Street: ${_address.street}"),
                    Text("Building: ${_address.building}"),
                    Text("Area: ${_address.area}"),
                    Text("City: ${_address.city}"),
                    Text("Country: ${_address.country}"),
                    Text("Postal Code: ${_address.postalCode}"),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
