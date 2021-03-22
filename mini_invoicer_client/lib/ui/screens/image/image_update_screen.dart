import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_invoicer_client/core/models/image_model.dart';
import 'package:mini_invoicer_client/infrastructure/services/db/firebase_cloud_firestore_service.dart';
import 'package:mini_invoicer_client/ui/screens/image/images_screen.dart';
import 'package:provider/provider.dart';

class ImageUpdateScreen extends StatefulWidget {
  final String _id;
  ImageUpdateScreen(this._id);

  @override
  _ImageUpdateScreenState createState() => _ImageUpdateScreenState();
}

class _ImageUpdateScreenState extends State<ImageUpdateScreen> {
  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  ImageModel _oldImageModel = ImageModel();
  ImageModel _newImageModel = ImageModel();

  @override
  Widget build(BuildContext context) {
    Stream<ImageModel> _imageStream = context
        .watch<FirebaseCloudFirestoreService>()
        .streamImageModel(widget._id);

    return StreamBuilder<ImageModel>(
      initialData: ImageModel(),
      stream: _imageStream,
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

        if (!snapshot.hasData) {
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

        _oldImageModel = snapshot.data;
        _titleController.text = _oldImageModel.title;
        _descriptionController.text = _oldImageModel.description;
        _newImageModel.id = _oldImageModel.id;

        return Scaffold(
          appBar: AppBar(
            title: Text("Update ${_oldImageModel.title}"),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    showDialog<bool>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete this image?"),
                          content: Text(
                              "You are about to delete this image forever!"),
                          actions: [
                            TextButton(
                              child: Text("No"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: Text("Yes"),
                              onPressed: () {
                                var result = context
                                    .read<FirebaseCloudFirestoreService>()
                                    .deleteImageModel(widget._id);

                                if (result != null) {
                                  Navigator.popUntil(context,
                                      ModalRoute.withName(ImagesScreen.ROUTE));
                                }
                              },
                            )
                          ],
                        );
                      },
                    );
                  })
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  onSaved: (value) => _newImageModel.title = value.trim(),
                  controller: _titleController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid image name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "ImageModel Name",
                  ),
                ),
                TextFormField(
                  onSaved: (value) => _newImageModel.description = value.trim(),
                  controller: _descriptionController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a valid image description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                  onFieldSubmitted: (value) {
                    value = value.trim();
                  },
                ),
                DropdownButtonFormField<bool>(
                  value: _oldImageModel.sensitive ?? false,
                  onChanged: (value) => _newImageModel.sensitive = value,
                  onSaved: (value) => _newImageModel.sensitive = value,
                  decoration: InputDecoration(labelText: "Country"),
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
                    ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        bool validationResult =
                            _formKey.currentState.validate();
                        if (validationResult) {
                          print("Form valid");
                        }
                        DocumentReference docRef = await context
                            .read<FirebaseCloudFirestoreService>()
                            .updateImageModel(_newImageModel);

                        if (docRef == null) {
                          print("Error updating image");
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Update"),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
