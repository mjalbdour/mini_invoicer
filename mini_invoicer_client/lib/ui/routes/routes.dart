import 'package:flutter/widgets.dart';
import 'package:mini_invoicer_client/ui/common/auth_wrapper.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AuthWrapper.Route: (context) => AuthWrapper(),
};
