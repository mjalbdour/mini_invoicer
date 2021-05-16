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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(BrandAddScreen.ROUTE),
        child: Icon(Icons.add),
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

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _brands.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BrandScreen(_brands[index].id))),
                child: Container(
                  height: 100.0,
                  child: Card(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 0,
                        width: 0,
                      ),
                      Text("${_brands[index].title}"),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_brands[index].country}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
