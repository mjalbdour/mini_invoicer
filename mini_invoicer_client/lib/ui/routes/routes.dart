import 'package:flutter/material.dart';

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
import 'package:mini_invoicer_client/ui/screens/image/image_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/image/images_screen.dart';
import 'package:mini_invoicer_client/ui/screens/inventory/inventories_screen.dart';
import 'package:mini_invoicer_client/ui/screens/inventory/inventory_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/inventory_type/inventory_type_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/inventory_type/inventory_types_screen.dart';
import 'package:mini_invoicer_client/ui/screens/invoice/invoices_screen.dart';
import 'package:mini_invoicer_client/ui/screens/pricing_type/pricing_type_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/pricing_type/pricing_types_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product/product_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product/products_screen.dart';
import 'package:mini_invoicer_client/ui/screens/account/accounts_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_quantity/product_quantities_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_quantity/product_quantity_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer/product_transfer_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer/product_transfers_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer_type/product_transfer_type_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer_type/product_transfer_types_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AuthWrapper.ROUTE: (context) => AuthWrapper(),
  AuthFormScreen.ROUTE: (_) => AuthFormScreen(),
  HomeScreen.ROUTE: (_) => HomeScreen(),
  ProductsScreen.ROUTE: (_) => ProductsScreen(),
  ProductAddScreen.ROUTE: (_) => ProductAddScreen(),
  PricingTypesScreen.ROUTE: (_) => PricingTypesScreen(),
  PricingTypeAddScreen.ROUTE: (_) => PricingTypeAddScreen(),
  BrandsScreen.ROUTE: (_) => BrandsScreen(),
  BrandAddScreen.ROUTE: (_) => BrandAddScreen(),
  CustomersScreen.ROUTE: (_) => CustomersScreen(),
  CustomerAddScreen.ROUTE: (_) => CustomerAddScreen(),
  EmployeesScreen.ROUTE: (_) => EmployeesScreen(),
  EmployeeAddScreen.ROUTE: (_) => EmployeeAddScreen(),
  ImagesScreen.ROUTE: (_) => ImagesScreen(),
  ImageAddScreen.ROUTE: (_) => ImageAddScreen(),
  AccountsScreen.ROUTE: (_) => AccountsScreen(),
  InventoriesScreen.ROUTE: (_) => InventoriesScreen(),
  InventoryAddScreen.ROUTE: (_) => InventoryAddScreen(),
  InventoryTypesScreen.ROUTE: (_) => InventoryTypesScreen(),
  InventoryTypeAddScreen.ROUTE: (_) => InventoryTypeAddScreen(),
  InvoicesScreen.ROUTE: (_) => InvoicesScreen(),
  ProductQuantitiesScreen.ROUTE: (_) => ProductQuantitiesScreen(),
  ProductQuantityAddScreen.ROUTE: (_) => ProductQuantityAddScreen(),
  ProductTransfersScreen.ROUTE: (_) => ProductTransfersScreen(),
  ProductTransferAddScreen.ROUTE: (_) => ProductTransferAddScreen(),
  ProductTransferTypesScreen.ROUTE: (_) => ProductTransferTypesScreen(),
  ProductTransferTypeAddScreen.ROUTE: (_) => ProductTransferTypeAddScreen()
};
