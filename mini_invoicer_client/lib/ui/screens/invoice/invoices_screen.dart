import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/invoice_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/currencies_data.dart';
import 'package:mini_invoicer_client/ui/screens/invoice/invoice_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/invoice/invoice_screen.dart';
import "package:provider/provider.dart";

class InvoicesScreen extends StatelessWidget {
  static const String ROUTE = "/invoices";

  @override
  Widget build(BuildContext context) {
    final _invoicesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInvoices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoices"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(InvoiceAddScreen.ROUTE))
        ],
      ),
      body: StreamBuilder<List<Invoice>>(
        initialData: [],
        stream: _invoicesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Oops! Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var _invoices = snapshot.data;
          if (_invoices.isEmpty) {
            return Center(
              child: Text("No invoices found"),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _invoices.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InvoiceScreen(_invoices[index].id))),
                title: Text(
                    "${_invoices[index].value} ${currencies[2].code} - ${_invoices[index].paymentType}"),
                subtitle: Text("${_invoices[index].customerId}"),
                trailing: Text("${_invoices[index].employeeId}"),
                leading: Text("${_invoices[index].id}"),
              );
            },
          );
        },
      ),
    );
  }
}
