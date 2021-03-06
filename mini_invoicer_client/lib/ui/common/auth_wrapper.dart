import 'package:firebase_auth/firebase_auth.dart';
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
      return Center(
        child: Text("Signed in"),
      );
      //TODO: return HomeScreen
    } else {
      return Center(child: Text("Not signed in"));
      // TODO: return SignInScreen
    }
  }
}
