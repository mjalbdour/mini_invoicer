import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/infrastructure/services/auth/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AuthFormScreen extends StatefulWidget {
  // ROUTE
  static const String ROUTE = '/auth/form';

  @override
  _AuthFormScreenState createState() => _AuthFormScreenState();
}

class _AuthFormScreenState extends State<AuthFormScreen> {
  FormType formType = FormType.SignIn;

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  formType == FormType.SignIn ? 'Sign in' : 'Sign up',
                  style: TextStyle(fontSize: 48.0),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(
                height: 16.0,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => formKey.currentState.reset(),
                    child: Text("reset"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => formType == FormType.SignIn
                        ? context
                            .read<FirebaseAuthenticationService>()
                            .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )
                        : context
                            .read<FirebaseAuthenticationService>()
                            .signUpWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                    icon: Icon(Icons.arrow_forward_rounded),
                    label: Text("next"),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              TextButton(
                onPressed: () => setState(
                  () => formType == FormType.SignIn
                      ? formType = FormType.SignUp
                      : formType = FormType.SignIn,
                ),
                child: Text(
                  formType == FormType.SignIn
                      ? "Sign up instead"
                      : "Sign in instead",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum FormType { SignIn, SignUp }
