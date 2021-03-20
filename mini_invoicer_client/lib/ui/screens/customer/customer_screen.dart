import 'package:flutter/material.dart';
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
    return StreamBuilder<Customer>(
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

        return Scaffold(
          appBar: AppBar(
            title: Text("${_customer.name}"),
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
              Text("${_customer.description}"),
              Text("Temp// addressId${_customer.addressId}"),
              Text("Temp// accountId${_customer.accountId}"),
            ],
          ),
        );
      },
    );
  }
}
