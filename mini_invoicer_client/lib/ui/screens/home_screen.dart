import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/infrastructure/services/auth/firebase_auth_service.dart';
import 'package:mini_invoicer_client/ui/screens/account/accounts_screen.dart';
import 'package:mini_invoicer_client/ui/screens/brand/brands_screen.dart';
import 'package:mini_invoicer_client/ui/screens/customer/customers_screen.dart';
import 'package:mini_invoicer_client/ui/screens/document/documents_screen.dart';
import 'package:mini_invoicer_client/ui/screens/employee/employees_screen.dart';
import 'package:mini_invoicer_client/ui/screens/image/images_screen.dart';
import 'package:mini_invoicer_client/ui/screens/inventory/inventories_screen.dart';
import 'package:mini_invoicer_client/ui/screens/invoice/invoices_screen.dart';
import 'package:mini_invoicer_client/ui/screens/pricing_type/pricing_types_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product/products_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_quantity/product_quantities_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer/product_transfers_screen.dart';
import 'package:mini_invoicer_client/ui/screens/product_transfer_type/product_transfer_types_screen.dart';
import 'package:mini_invoicer_client/ui/screens/transaction/transactions_screen.dart';

// import 'package:mini_invoicer_client/ui/screens/vendor/vendor_screen.dart';
import 'package:provider/provider.dart';

import 'inventory_type/inventory_types_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () =>
                  context.read<FirebaseAuthenticationService>().signOut(),
            ),
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(AccountsScreen.ROUTE)},
              title: Text("Accounts"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(BrandsScreen.ROUTE)},
              title: Text("Brands"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(CustomersScreen.ROUTE)},
              title: Text("Customers"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(DocumentsScreen.ROUTE)},
              title: Text("Documents"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(EmployeesScreen.ROUTE)},
              title: Text("Employees"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(ImagesScreen.ROUTE)},
              title: Text("Images"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(InventoriesScreen.ROUTE)},
              title: Text("Inventories"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(InventoryTypesScreen.ROUTE)},
              title: Text("Inventory Types"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(InvoicesScreen.ROUTE)},
              title: Text("Invoices"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(PricingTypesScreen.ROUTE)},
              title: Text("Pricing Types"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(ProductsScreen.ROUTE)},
              title: Text("Products"),
            ),
            ListTile(
              onTap: () => {
                Navigator.of(context).pushNamed(ProductTransfersScreen.ROUTE)
              },
              title: Text("Product Transfers"),
            ),
            ListTile(
              onTap: () => {
                Navigator.of(context)
                    .pushNamed(ProductTransferTypesScreen.ROUTE)
              },
              title: Text("Product Transfer Types"),
            ),
            ListTile(
              onTap: () =>
                  {Navigator.of(context).pushNamed(TransactionsScreen.ROUTE)},
              title: Text("Transactions"),
            ),
            ListTile(
              onTap: () => {
                Navigator.of(context).pushNamed(ProductQuantitiesScreen.ROUTE)
              },
              title: Text("Product Quantities"),
            ),
            // ListTile(
            //   onTap: () =>
            //   {Navigator.of(context).pushNamed(VendorScreen.ROUTE)},
            //   title: Text("Vendor"),
            // ),
          ],
        ));
  }
}
