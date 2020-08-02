import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:mini_invoicer_app/widgets/auth_widget.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const String title = "sign in";
  static const String route = "/${AuthWidget.route}/sign-in";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _signInFormKey = GlobalKey<FormState>();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    print(_emailController.text);
    if (_signInFormKey.currentState.validate()) {
      try {
        final auth = Provider.of<FirebaseAuthService>(context, listen: false);
        await auth.signInWithEmailAndPassword(email, password);
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
                    onPressed: () {
                      _signInFormKey.currentState.save();
                      _signInWithEmailAndPassword(context);
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
