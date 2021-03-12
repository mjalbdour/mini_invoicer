import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/transaction_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  String _id;
  String _route;
  TransactionScreen(String id) {
    this._id = id;
    this._route = "/transactions/$id";
  }

  @override
  Widget build(BuildContext context) {
    Stream<TransactionModel> _transactionStream =
        context.watch<FirebaseCloudFirestoreService>().streamTransaction(_id);
    return StreamBuilder<TransactionModel>(
      initialData: TransactionModel(),
      stream: _transactionStream,
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

        TransactionModel _transaction = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_transaction.id}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_transaction.senderAccountId}"),
              Text("${_transaction.receiverAccountId}"),
              Text("${_transaction.value}"),
            ],
          ),
        );
      },
    );
  }
}
