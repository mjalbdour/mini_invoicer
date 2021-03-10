import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/pricing_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/pricing_type/pricing_type_screen.dart';
import "package:provider/provider.dart";

class PricingTypesScreen extends StatelessWidget {
  static const String ROUTE = "/pricingTypes";
  @override
  Widget build(BuildContext context) {
    final _pricingTypesStream =
        context.watch<FirebaseCloudFirestoreService>().streamPricingTypes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Types"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<PricingType>>(
        initialData: [],
        stream: _pricingTypesStream,
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

          var _pricingTypes = snapshot.data;
          if (_pricingTypes.isEmpty) {
            return Center(
              child: Text("No pricing types found"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _pricingTypes.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PricingTypeScreen(_pricingTypes[index].id))),
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
                        Text("${_pricingTypes[index].name}"),
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${_pricingTypes[index].id}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
