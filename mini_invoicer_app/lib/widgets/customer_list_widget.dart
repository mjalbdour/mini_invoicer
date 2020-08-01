import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/widgets/customer_tile_widget.dart';

class CustomerListWidget extends StatefulWidget {
  final String collectionPath;
  CustomerListWidget({@required this.collectionPath});
  @override
  _CustomerListWidgetState createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(widget.collectionPath).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );

          default:
            return snapshot.data.documents.isEmpty
                ? Center(
                    child: Text("no customers yet"),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return CustomerTileWidget(
                        customer: Customer.fromMap(
                            snapshot.data.documents[index].data,
                            snapshot.data.documents[index].documentID),
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                  );
        }
      },
    );
  }
}
