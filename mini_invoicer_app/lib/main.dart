import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/widgets/auth_widget.dart';
import 'package:provider/provider.dart';

void main() => runApp(MiniInvoicer());

class MiniInvoicer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuth>(
      create: (_) => FirebaseAuth.instance,
      child: MaterialApp(
        title: "Mini Invoicer",
        home: AuthWidget(),
      ),
    );
  }
}
