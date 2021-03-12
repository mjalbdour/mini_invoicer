import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/transaction_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class TransactionsScreen extends StatelessWidget {
  static const String ROUTE = "/transactions";
  @override
  Widget build(BuildContext context) {
    final _transactionsStream =
        context.watch<FirebaseCloudFirestoreService>().streamTransactions();
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction s"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<TransactionModel>>(
        initialData: [],
        stream: _transactionsStream,
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

          var _transactions = snapshot.data;
          if (_transactions.isEmpty) {
            return Center(
              child: Text("No transactions found"),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TransactionScreen(_transactions[index].id))),
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
                      Text("${_transactions[index].id}"),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${_transactions[index].value}"),
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
