import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/vendor_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class VendorScreen extends StatelessWidget {
  final String _id;
  VendorScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<Vendor> _vendorStream =
        context.watch<FirebaseCloudFirestoreService>().streamVendor(_id);
    return StreamBuilder<Vendor>(
      initialData: Vendor(),
      stream: _vendorStream,
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

        Vendor _vendor = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_vendor.name}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("Temp// Display Picture carousel"),
              Text("${_vendor.description}"),
              Text("Tax Number: ${_vendor.taxNumber}"),
              Text("Temp// Address Id: ${_vendor.addressId}"),
              Text("Temp// Account Id: ${_vendor.accountId}"),
            ],
          ),
        );
      },
    );
  }
}
