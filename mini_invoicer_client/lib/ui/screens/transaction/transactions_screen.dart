import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/transaction_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/currencies_data.dart';
import 'package:mini_invoicer_client/ui/screens/transaction/transaction_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/transaction/transaction_screen.dart';
import "package:provider/provider.dart";

class TransactionsScreen extends StatelessWidget {
  static const String ROUTE = "/transactions";

  @override
  Widget build(BuildContext context) {
    final _transactionsStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamTransactionModels();
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(TransactionAddScreen.ROUTE))
        ],
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
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TransactionScreen(_transactions[index].id))),
                title:
                    Text("${_transactions[index].value} ${currencies[2].code}"),
                subtitle: Text(
                    "${_transactions[index].fromAccountId} to ${_transactions[index].toAccountId}"),
                trailing: Text("${_transactions[index].timestamp}"),
                leading: Text("SN: ${_transactions[index].id}"),
              );
            },
          );
        },
      ),
    );
  }
}
