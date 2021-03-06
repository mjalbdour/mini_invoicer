import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/infrastructure/services/auth/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () =>
                context.read<FirebaseAuthenticationService>().signOut(),
          ),
        ],
      ),
      body: Center(
        child: Text("home screen"),
      ),
    );
  }
}
