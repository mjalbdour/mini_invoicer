import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/infrastructure/services/auth/firebase_auth_service.dart';
import 'package:mini_invoicer_client/ui/screens/product/products_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () =>
                context.read<FirebaseAuthenticationService>().signOut(),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Products"),
          onPressed: () =>
              Navigator.of(context).pushNamed(ProductsScreen.ROUTE),
        ),
      ),
    );
  }
}
