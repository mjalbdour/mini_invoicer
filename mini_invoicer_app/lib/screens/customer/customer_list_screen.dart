import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/customer/customer_create_screen.dart';

class CustomerListScreen extends StatefulWidget {
  static const String title = "customers";
  static const String route = "/$title";

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("/customers").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    // TODO: Implement add Customer
                    Navigator.pushNamed(context, CustomerCreateScreen.route);
                  },
                  child: Icon(Icons.add),
                ),
                appBar: AppBar(
                  title: Text(CustomerListScreen.title),
                ),
                body: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data.documents[index]["title"]),
                      ),
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                ),
              )
            : CircularProgressIndicator();
      },
    );
  }
}
