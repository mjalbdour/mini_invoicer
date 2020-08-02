import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/auth/sign_in_screen.dart';
import 'package:mini_invoicer_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuth>(context);
    return StreamProvider<FirebaseUser>.value(
      value: auth.onAuthStateChanged,
      builder: (context, _) {
        return Consumer<FirebaseUser>(builder: (_, value, __) {
          if (value != null) print(value.getIdToken());
          return value == null ? SignInScreen() : HomeScreen();
        });
      },
      updateShouldNotify: (previous, current) => previous != current,
    );
  }
}
