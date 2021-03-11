import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/invoice_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class InvoicesScreen extends StatelessWidget {
  static const String ROUTE = "/invoices";
  @override
  Widget build(BuildContext context) {
    final _invoicesStream =
        context.watch<FirebaseCloudFirestoreService>().streamInvoices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice s"),
        centerTitle: true,
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
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InvoiceScreen(_invoices[index].id))),
                child: Container(
                  height: 100.0,
                  child: Card(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 0,
                        width: 0,
                      ),
                      Text("${_invoices[index].id}"),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${_invoices[index].value}"),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
