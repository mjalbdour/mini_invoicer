import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/pricing_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/pricing_type/pricing_type_add_screen.dart';
import 'package:mini_invoicer_client/ui/screens/pricing_type/pricing_type_screen.dart';
import "package:provider/provider.dart";

class PricingTypesScreen extends StatelessWidget {
  static const String ROUTE = "/pricingtypes";

  @override
  Widget build(BuildContext context) {
    final _pricingTypesStream =
        context.watch<FirebaseCloudFirestoreService>().streamPricingTypes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Types"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(PricingTypeAddScreen.ROUTE))
        ],
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
          } else {
            return ListView.builder(
                itemCount: _pricingTypes.length,
                itemBuilder: (context, index) {
              print(_pricingTypes.length);
              return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PricingTypeScreen(_pricingTypes[index].id))),
                title: Text("${_pricingTypes[index].title}"),
                subtitle: Text("${_pricingTypes[index].description}"),
              );
            });
          }
        },
      ),
    );
  }
}
