import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/document_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
// import 'package:mini_invoicer_client/ui/screens/document/document_add_screen.dart';
// import 'package:mini_invoicer_client/ui/screens/document/document_screen.dart';
import "package:provider/provider.dart";

class DocumentsScreen extends StatelessWidget {
  static const String ROUTE = "/documentmodels";

  @override
  Widget build(BuildContext context) {
    final _documentsStream =
    context.watch<FirebaseCloudFirestoreService>().streamDocumentModels();
    return Scaffold(
      appBar: AppBar(
        title: Text("Documents"),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).pushNamed(DocumentAddScreen.ROUTE),
      //   child: Icon(Icons.add),
      // ),
      body: StreamBuilder<List<DocumentModel>>(
        initialData: [],
        stream: _documentsStream,
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

          var _documents = snapshot.data;
          if (_documents.isEmpty) {
            return Center(
              child: Text("No documents found"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _documents.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => DocumentModelScreen(_documents[index].id))),
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
                          Text("${_documents[index].title}"),
                          Container(
                            color: Colors.black,
                            padding: EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   "${_documents[index].ownerId}",
                                //   style: TextStyle(color: Colors.white),
                                // ),
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
