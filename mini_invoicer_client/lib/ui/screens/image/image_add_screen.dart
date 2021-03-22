import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/image_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import "package:provider/provider.dart";

class ImageAddScreen extends StatefulWidget {
  static const String ROUTE = "/imagemodels/add";

  @override
  _ImageAddScreenState createState() => _ImageAddScreenState();
}

class _ImageAddScreenState extends State<ImageAddScreen> {
  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  ImageModel _imageModel = ImageModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Image"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              autofocus: true,
              onFieldSubmitted: (value) {
                value = value.trim();
              },
              onSaved: (value) => _imageModel.title = value.trim(),
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextFormField(
              onFieldSubmitted: (value) {
                value = value.trim();
              },
              onSaved: (value) => _imageModel.description = value.trim(),
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            DropdownButtonFormField<bool>(
              value: false,
              onChanged: (value) => _imageModel.sensitive = value,
              onSaved: (value) => _imageModel.sensitive = value,
              decoration: InputDecoration(labelText: "Sensitive?"),
              items: List.generate(
                2,
                (index) => index % 2 == 0
                    ? DropdownMenuItem(
                        child: Text("No"),
                        value: false,
                      )
                    : DropdownMenuItem(
                        child: Text("Yes"),
                        value: true,
                      ),
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => _formKey.currentState.reset(),
                  child: Text("reset"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState.save();
                    DocumentReference docRef = await context
                        .read<FirebaseCloudFirestoreService>()
                        .addImageModel(_imageModel);

                    if (docRef == null) {
                      print("Error adding imageModel");
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Add"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
