import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/screens/customer/customer_detail_screen.dart';

class CustomerListScreen extends StatefulWidget {
  static const String title = "customers";
  static const String route = "/$title";

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final CollectionReference _customers =
      Firestore.instance.collection(CustomerListScreen.route);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(CustomerListScreen.title),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _customers.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              default:
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return CustomerTile(
                      customer: Customer.fromMap(
                          snapshot.data.documents[index].data,
                          snapshot.data.documents[index].documentID),
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                );
            }
          },
        ));
  }
}

class CustomerTile extends StatelessWidget {
  final Customer customer;
  CustomerTile({@required this.customer});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(customer.name ?? "name not available, bad dataschema..."),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CustomerDetailScreen(customer: customer)));
      },
    );
  }
}
