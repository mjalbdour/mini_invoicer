import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/invoice_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatelessWidget {
  String _id;
  String _route;
  InvoiceScreen(String id) {
    this._id = id;
    this._route = "/invoices/$id";
  }

  @override
  Widget build(BuildContext context) {
    Stream<Invoice> _invoiceStream =
        context.watch<FirebaseCloudFirestoreService>().streamInvoice(_id);
    return StreamBuilder<Invoice>(
      initialData: Invoice(),
      stream: _invoiceStream,
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

        Invoice _invoice = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_invoice.id}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_invoice.employeeId}"),
              Text("${_invoice.customerId}"),
              Text("${_invoice.value}"),
            ],
          ),
        );
      },
    );
  }
}
