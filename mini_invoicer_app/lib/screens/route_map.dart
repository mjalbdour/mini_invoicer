import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_invoicer_app/screens/auth/sign_in_screen.dart';
import 'package:mini_invoicer_app/screens/customer/customer_list_screen.dart';
import 'package:mini_invoicer_app/screens/home_screen.dart';
import 'package:mini_invoicer_app/screens/invoice/invoice_list_screen.dart';
import 'package:mini_invoicer_app/screens/landing_screen.dart';
import 'package:mini_invoicer_app/screens/order/order_list_screen.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';
import 'package:mini_invoicer_app/screens/receipt/receipt_list_screen.dart';

Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{
  LandingScreen.route: (context) => LandingScreen(),
  SignInScreen.route: (context) => SignInScreen(),
  HomeScreen.route: (context) => HomeScreen(),
  ProductListScreen.route: (context) => ProductListScreen(),
  CustomerListScreen.route: (context) => CustomerListScreen(),
  InvoiceListScreen.route: (context) => InvoiceListScreen(),
  OrderListScreen.route: (context) => OrderListScreen(),
  ReceiptListScreen.route: (context) => ReceiptListScreen(),
};
