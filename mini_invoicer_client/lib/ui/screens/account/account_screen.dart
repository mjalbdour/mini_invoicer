import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/account_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  final String _id;

  AccountScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<Account> _accountStream =
        context.watch<FirebaseCloudFirestoreService>().streamAccount(_id);
    return StreamBuilder<Account>(
      initialData: Account(),
      stream: _accountStream,
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

        Account _account = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_account.id}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("Title: ${_account.title}"),
              Text("Balance: ${_account.balance}"),
              Text("Last Updated: ${_account.lastUpdated}"),
              Text("Temp// Owner Id: ${_account.ownerId}"),
            ],
          ),
        );
      },
    );
  }
}
