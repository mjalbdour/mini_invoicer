import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const String title = "sign in";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email;
  String _password;
  int companyNumber;

  var _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthService>(context);
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
                onChanged: (value) => _email = value,
                validator: (input) {
                  if (!input.contains("@")) {
                    return "please provide a valid email";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "password",
                ),
                obscureText: true,
                onChanged: (value) => _password = value,
                validator: (input) {
                  if (input.length < 8 || input.length > 32) {
                    return "password must be between 8 and 32 characters";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "company number",
                ),
                validator: (input) {
                  if (input.runtimeType != num)
                    return "enter your correct company number";
                  return null;
                },
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
                    onPressed: () async {
                      await auth.signInWithEmailAndPassword(
                          email: _email.trim(), password: _password);
                    },
                    child: Text("sign in"),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
