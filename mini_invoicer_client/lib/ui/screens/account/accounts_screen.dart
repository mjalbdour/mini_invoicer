import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/account_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/account/account_screen.dart';
import "package:provider/provider.dart";

class AccountsScreen extends StatelessWidget {
  static const String ROUTE = "/accounts";

  @override
  Widget build(BuildContext context) {
    final _accountsStream =
        context.watch<FirebaseCloudFirestoreService>().streamAccounts();
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Account>>(
        initialData: [],
        stream: _accountsStream,
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

          var _accounts = snapshot.data;
          if (_accounts.isEmpty) {
            return Center(
              child: Text("No accounts found"),
            );
          }

          return ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              onTap: () => {
                /*Navigate to account screen based on id*/
              },
              title: Text("${_accounts[index].title}"),
              subtitle: Text("${_accounts[index].balance}"),
            );
          });
        },
      ),
    );
  }
}
