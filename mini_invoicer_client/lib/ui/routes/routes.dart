import 'package:flutter/widgets.dart';

// Screens | Wrappers
import 'package:mini_invoicer_client/ui/screens/auth/auth_wrapper.dart';
import 'package:mini_invoicer_client/ui/screens/auth/auth_form_screen.dart';
import 'package:mini_invoicer_client/ui/screens/brand/brand_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/brand/brands_screen.dart';
import 'package:mini_invoicer_client/ui/screens/customer/customer_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/customer/customers_screen.dart';
import 'package:mini_invoicer_client/ui/screens/employee/employee_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/employee/employees_screen.dart';
import 'package:mini_invoicer_client/ui/screens/home_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product/product_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product/products_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AuthWrapper.ROUTE: (context) => AuthWrapper(),
  AuthFormScreen.ROUTE: (context) => AuthFormScreen(),
  HomeScreen.ROUTE: (context) => HomeScreen(),
  ProductsScreen.ROUTE: (context) => ProductsScreen(),
  ProductAddScreen.ROUTE: (context) => ProductAddScreen(),
  BrandsScreen.ROUTE: (context) => BrandsScreen(),
  BrandAddScreen.ROUTE: (context) => BrandAddScreen(),
  CustomersScreen.ROUTE: (context) => CustomersScreen(),
  CustomerAddScreen.ROUTE: (context) => CustomerAddScreen(),
  EmployeesScreen.ROUTE: (context) => EmployeesScreen(),
  EmployeeAddScreen.ROUTE: (context) => EmployeeAddScreen(),
};
