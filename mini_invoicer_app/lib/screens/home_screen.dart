import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/company/company_detail_screen.dart';
import 'package:mini_invoicer_app/screens/customer/customer_list_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';
import 'package:mini_invoicer_app/widgets/home_tile_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CompanyDetailScreen()));
            },
            child: Icon(
              Icons.info,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              await auth.signOut();
            },
            child: Text(
              "sign out",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          HomeTileWidget(
            name: ProductListScreen.title,
            onTap: (BuildContext _context) {
              Navigator.push(
                  _context,
                  MaterialPageRoute(
                      builder: (_context) => ProductListScreen()));
            },
          ),
          HomeTileWidget(
            name: CustomerListScreen.title,
            onTap: (BuildContext _context) {
              Navigator.push(
                  _context,
                  MaterialPageRoute(
                      builder: (_context) => CustomerListScreen()));
            },
          ),
        ],
      ),
    );
  }
}
