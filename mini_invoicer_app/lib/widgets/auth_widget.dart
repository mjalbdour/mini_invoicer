import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/auth/sign_in_screen.dart';
import 'package:mini_invoicer_app/screens/home_screen.dart';
import 'package:mini_invoicer_app/services/cloud_firestore_service.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  static const String route = "/auth";
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

// TODO: FIX PRODUCTS PROVIDER.

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.active) {
            final user = userSnapshot.data;
            return user == null
                ? SignInScreen()
                : Provider<FirestoreService>(
                    create: (_) => FirestoreService(),
                    child: HomeScreen(),
                  );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
