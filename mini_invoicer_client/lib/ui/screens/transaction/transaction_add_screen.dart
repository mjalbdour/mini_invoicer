import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_invoicer_client/core/models/account_model.dart';
import "package:provider/provider.dart";
import 'package:mini_invoicer_client/core/models/transaction_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/constants/currencies_data.dart';

class TransactionAddScreen extends StatefulWidget {
  static const String ROUTE = "/transactionmodels/add";

  @override
  _TransactionAddScreenState createState() => _TransactionAddScreenState();
}

class _TransactionAddScreenState extends State<TransactionAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  TransactionModel _transactionModel = TransactionModel();

  @override
  Widget build(BuildContext context) {
    Stream<List<Account>> _accountsStream =
        context.watch<FirebaseCloudFirestoreService>().streamAccounts();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Transfer"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          children: [
            /*** From Account ***/
            StreamBuilder<List<Account>>(
                initialData: [],
                stream: _accountsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text("Error loading accounts")),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                          child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                            "You can't add transactions without any accounts. Go back"),
                      )),
                    );
                  }

                  var _accounts = snapshot.data;
                  return DropdownButtonFormField(
                    onSaved: (value) => _transactionModel.fromAccountId = value,
                    onChanged: (value) =>
                        _transactionModel.fromAccountId = value,
                    decoration: InputDecoration(labelText: "From Account"),
                    items: _accounts
                        .map((account) => DropdownMenuItem(
                              value: account.id,
                              child: Text("${account.title}"),
                            ))
                        .toList(),
                  );
                }),
            /*** To Account ***/
            StreamBuilder<List<Account>>(
                initialData: [],
                stream: _accountsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text("Error loading accounts")),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.data.isEmpty) {
                    return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                              "You can't add transactions without any accounts. Go back"),
                        ));
                  }

                  var _accounts = snapshot.data;
                  return DropdownButtonFormField(
                    onSaved: (value) => _transactionModel.fromAccountId = value,
                    onChanged: (value) =>
                        _transactionModel.fromAccountId = value,
                    decoration: InputDecoration(labelText: "To Account"),
                    items: _accounts
                        .map((account) => DropdownMenuItem(
                              value: account.id,
                              child: Text("${account.title}"),
                            ))
                        .toList(),
                  );
                }),
            TextFormField(
              autofocus: true,
              onSaved: (value) {
                value = value.trim();
                _transactionModel.value = double.parse(value);
              },
              controller: _valueController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              decoration: InputDecoration(
                labelText: "Value - ${currencies[2].code}",
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState.save();
                    _transactionModel.timestamp = DateTime.now();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addTransactionModel(_transactionModel);

                    if (docRef == null) {
                      print("Error adding inventory type");
                    } else {
                      // _transactionModel.id = docRef.id;
                      // _transactionModel.sourceTransactionModelId = docRef.id;
                      // await context
                      //     .read<FirebaseCloudFirestoreService>()
                      //     .updateTransactionModel(_transactionModel);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Add"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
