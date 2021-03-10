import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/auth/auth_wrapper.dart';
import 'package:mini_invoicer_client/ui/routes/routes.dart';
import 'package:provider/provider.dart';

import 'infrastructure/services/auth/firebase_auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MiniInvoicer());
}

class MiniInvoicer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthenticationService>(
          create: (_) => FirebaseAuthenticationService(FirebaseAuth.instance),
        ),
        Provider<FirebaseCloudFirestoreService>(
          create: (_) =>
              FirebaseCloudFirestoreService(FirebaseFirestore.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<FirebaseAuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Mini Invoicer',
        routes: routes,
        initialRoute: AuthWrapper.ROUTE,
      ),
    );
  }
}
