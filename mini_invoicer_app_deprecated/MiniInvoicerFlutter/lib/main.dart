import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/services/firebase_auth_service.dart';
import 'package:mini_invoicer_app/services/image_picker_service.dart';
import 'package:mini_invoicer_app/widgets/auth_widget.dart';
import 'package:provider/provider.dart';

void main() => runApp(MiniInvoicer());

class MiniInvoicer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (context) => FirebaseAuthService(),
        ),
        Provider<ImagePickerService>(
          create: (context) => ImagePickerService(),
        ),
      ],
      builder: (BuildContext context, Widget _) {
        return MaterialApp(
          home: AuthWidget(),
        );
      },
    );
  }
}
