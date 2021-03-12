import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/image_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/image/image_screen.dart';
import "package:provider/provider.dart";

class ImagesScreen extends StatelessWidget {
  static const String ROUTE = "/images";

  @override
  Widget build(BuildContext context) {
    final _imagesStream =
        context.watch<FirebaseCloudFirestoreService>().streamImageModels();
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ImageModel>>(
        initialData: [],
        stream: _imagesStream,
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

          var _images = snapshot.data;
          if (_images.isEmpty) {
            return Center(
              child: Text("No images found"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _images.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ImageModelScreen(_images[index].id))),
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
                      Text("${_images[index].title}"),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_images[index].ownerId}",
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
