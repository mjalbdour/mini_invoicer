import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/image_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:provider/provider.dart';

class ImageModelScreen extends StatelessWidget {
  String _id;
  String _route;
  ImageModelScreen(String id) {
    this._id = id;
    this._route = "/images/$id";
  }

  @override
  Widget build(BuildContext context) {
    Stream<ImageModel> _imageModelStream =
        context.watch<FirebaseCloudFirestoreService>().streamImageModel(_id);
    return StreamBuilder<ImageModel>(
      initialData: ImageModel(),
      stream: _imageModelStream,
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

        ImageModel _imageModel = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text("${_imageModel.title}"),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text("${_imageModel.description}"),
              Text("${_imageModel.ownerId}"),
            ],
          ),
        );
      },
    );
  }
}
