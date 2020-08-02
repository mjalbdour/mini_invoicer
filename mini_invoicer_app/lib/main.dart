import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/route_map.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:mini_invoicer_app/widgets/auth_widget.dart';
import 'package:provider/provider.dart';

void main() => runApp(MiniInvoicer());

class MiniInvoicer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuthService>(
      create: (_) => FirebaseAuthService(),
      child: MaterialApp(
        title: "Mini Invoicer",
        routes: routeMap,
        initialRoute: AuthWidget.route,
      ),
    );
  }
}
