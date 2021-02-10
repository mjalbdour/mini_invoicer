import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/auth/sign_in_screen.dart';
import 'package:mini_invoicer_app/screens/home_screen.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthService>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                body: Center(
                    child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text("checking user status"),
                  ],
                )),
              );

            default:
              return snapshot.data == null ? SignInScreen() : HomeScreen();
          }
        });
  }
}
