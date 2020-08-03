import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const String title = "sign in";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "email",
                ),
                validator: (input) {
                  if (!input.contains("@")) {
                    return "please provide a valid email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
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
                      _signInFormKey.currentState.save();
                      _emailController.text.trim();
                      await auth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
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
