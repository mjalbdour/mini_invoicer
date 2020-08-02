import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/customer/customer_list_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:mini_invoicer_app/widgets/home_tile_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "/home";

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
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
              onPressed: () => _signOut(context),
              child: Text(
                "sign out",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          HomeTileWidget(
            name: ProductListScreen.title,
            route: ProductListScreen.route,
          ),
          HomeTileWidget(
            name: CustomerListScreen.title,
            route: CustomerListScreen.route,
          ),
        ],
      ),
    );
  }
}
