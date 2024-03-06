import 'dart:io';
import 'package:farm2fabric/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String authorName = '';
  late String title = '';
  late String desc = '';
  File? selectedImage; // Initialize selectedImage as nullable
  bool _isLoading = false;

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image != null ? File(image.path) : null;
    });
  }

  Future<void> uploadBlog() async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select an image.'),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("blogImages")
        .child("${randomAlphaNumeric(9)}.jpg");

    firebase_storage.UploadTask task =
        firebaseStorageRef.putFile(selectedImage!);

    // Await the task completion
    await task.whenComplete(() => null);

    // Get the download URL
    String downloadUrl = await firebaseStorageRef.getDownloadURL();

    // Upload other blog details along with the image URL
    await FirebaseFirestore.instance.collection("blogs").add({
      "authorName": authorName,
      "title": title,
      "desc": desc,
      "imgUrl": downloadUrl,
    });

    // Clear selected image and reset form fields after upload
    setState(() {
      selectedImage = null;
      authorName = '';
      title = '';
      desc = '';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Flutter Blog",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            onPressed: uploadBlog,
            icon: Icon(Icons.file_upload),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: getImage,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.5), // Transparent white background
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Author Name"),
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Desc"),
                          onChanged: (val) {
                            desc = val;
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
