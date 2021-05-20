import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/brand/brand_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/brand/brand_screen.dart';
import "package:provider/provider.dart";

class BrandsScreen extends StatelessWidget {
  static const String ROUTE = "/brands";

  @override
  Widget build(BuildContext context) {
    final _brandsStream =
        context.watch<FirebaseCloudFirestoreService>().streamBrands();
    return Scaffold(
      appBar: AppBar(
        title: Text("Brands"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(BrandAddScreen.ROUTE),
          )
        ],
      ),
      body: StreamBuilder<List<Brand>>(
        initialData: [],
        stream: _brandsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Oops! Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var _brands = snapshot.data;
          if (_brands.isEmpty) {
            return Center(
              child: Text("No brands found"),
            );
          }

          return ListView.builder(
              itemCount: _brands.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BrandScreen(_brands[index].id))),
                  title: Text("${_brands[index].title}"),
                  subtitle: Text("${_brands[index].country}"),
                );
              });
        },
      ),
    );
  }
}
