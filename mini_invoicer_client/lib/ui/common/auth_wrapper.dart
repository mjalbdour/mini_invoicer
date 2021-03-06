import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_invoicer_client/ui/screens/auth/sign_in_screen.dart';
import 'package:mini_invoicer_client/ui/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class AuthWrapper extends StatelessWidget {
  static const String Route = '/auth';
  const AuthWrapper({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomeScreen();
    } else {
      return SignInScreen();
    }
  }
}
