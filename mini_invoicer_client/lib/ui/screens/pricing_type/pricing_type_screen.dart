import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/pricing_type_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class PricingTypeScreen extends StatelessWidget {
  final String _id;
  PricingTypeScreen(this._id);

  @override
  Widget build(BuildContext context) {
    Stream<PricingType> _pricingTypeStream =
        context.watch<FirebaseCloudFirestoreService>().streamPricingType(_id);
    return StreamBuilder<PricingType>(
      initialData: PricingType(),
      stream: _pricingTypeStream,
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

        PricingType _pricingType = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_pricingType.title}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_pricingType.description}"),
            ],
          ),
        );
      },
    );
  }
}
