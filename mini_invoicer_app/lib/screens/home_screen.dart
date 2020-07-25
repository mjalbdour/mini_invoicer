import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/customer/customer_list_screen.dart';
import 'package:mini_invoicer_app/screens/invoice/invoice_list_screen.dart';
import 'package:mini_invoicer_app/screens/order/order_list_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';
import 'package:mini_invoicer_app/screens/receipt/receipt_list_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "/home";

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          FlatButton(
              onPressed: _signOut,
              child: Text(
                "sign out",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          HomeListTile(
            name: OrderListScreen.title,
            route: OrderListScreen.route,
          ),
          HomeListTile(
            name: ProductListScreen.title,
            route: ProductListScreen.route,
          ),
          HomeListTile(
            name: CustomerListScreen.title,
            route: CustomerListScreen.route,
          ),
          HomeListTile(
            name: InvoiceListScreen.title,
            route: InvoiceListScreen.route,
          ),
          HomeListTile(
            name: ReceiptListScreen.title,
            route: ReceiptListScreen.route,
          ),
        ],
      ),
    );
  }
}

class HomeListTile extends StatelessWidget {
  final String name;
  final String route;

  const HomeListTile({
    Key key,
    @required this.name,
    @required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this.name),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
