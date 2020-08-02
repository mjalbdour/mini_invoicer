import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_invoicer_app/screens/auth/sign_in_screen.dart';
import 'package:mini_invoicer_app/screens/customer/customer_list_screen.dart';
import 'package:mini_invoicer_app/screens/home_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';
import 'package:mini_invoicer_app/widgets/auth_widget.dart';

Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{
  AuthWidget.route: (context) => AuthWidget(),
  SignInScreen.route: (context) => SignInScreen(),
  HomeScreen.route: (context) => HomeScreen(),
  ProductListScreen.route: (context) => ProductListScreen(),
  CustomerListScreen.route: (context) => CustomerListScreen(),
};
