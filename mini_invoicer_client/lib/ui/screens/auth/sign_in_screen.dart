import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  // ROUTE
  static const String Route = '/auth/signin';

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Form fields Editing CONTROLLERS
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 48.0),
                ),
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
                    onPressed: () => null,
                    icon: Icon(Icons.arrow_forward_rounded),
                    label: Text("next"),
                  ),
                ],
              ),
              TextButton(onPressed: () => null, child: Text("Create Account")),
            ],
          ),
        ),
      ),
    );
  }
}
