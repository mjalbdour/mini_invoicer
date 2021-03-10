import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/brand_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class BrandScreen extends StatelessWidget {
  String _id;
  String _route;
  BrandScreen(String id) {
    this._id = id;
    this._route = "/brands/$id";
  }

  @override
  Widget build(BuildContext context) {
    Stream<Brand> _brandStream =
        context.watch<FirebaseCloudFirestoreService>().streamBrand(_id);
    return StreamBuilder<Brand>(
      initialData: Brand(),
      stream: _brandStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text("Oops! Something went wrong"),
                  IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        Brand _brand = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_brand.name}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_brand.description}"),
              Text("${_brand.country}"),
            ],
          ),
        );
      },
    );
  }
}
