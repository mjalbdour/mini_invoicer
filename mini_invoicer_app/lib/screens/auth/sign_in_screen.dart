import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String title = "authentication";
  static const String route = "/$title";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email;
  String _password;

  var _signInFormKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    if (_signInFormKey.currentState.validate()) {
      _signInFormKey.currentState.save();
      print('"$_email"');
      print('"$_password"');
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
      } catch (e) {
        throw e;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SignInScreen.title),
      ),
      body: Form(
          key: _signInFormKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "email",
                ),
                validator: (input) {
                  if (!input.contains("@")) {
                    return "please provide a valid email";
                  }
                  return null;
                },
                onSaved: (input) => _email = input.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "password",
                ),
                obscureText: true,
                validator: (input) {
                  if (input.length < 8 || input.length > 32) {
                    return "password must be between 8 and 32 characters";
                  }
                  return null;
                },
                onSaved: (input) => _password = input,
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _signInFormKey.currentState.reset();
                      });
                    },
                    child: Text("reset"),
                  ),
                  RaisedButton(
                    onPressed: signIn,
                    child: Text("sign in"),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
