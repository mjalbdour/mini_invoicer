import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MiniInvoicer());
}

class MiniInvoicer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mini Invoicer",
      home: Scaffold(
        body: Center(
          child: Text("Mini Invoicer"),
        ),
      ),
    );
  }
}
