import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPicture extends StatefulWidget {
  String? email;
  String? password;
  String? username;

  AddPicture({super.key});

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;
  final ImagePicker _picker = ImagePicker();

  void selectImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _image = imageBytes;
      });
    }
  }

  void selectImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _image = imageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Picture')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Holbegram",
              style: TextStyle(fontFamily: "Billabong", fontSize: 50),
            ),
            Image.asset('assets/images/logo.webp', width: 80, height: 60),
            SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Text(
                    "Hello, Jhon Doe Welcome to Holbegram.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Choose an image from your gallery or tak a new one.",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            _image != null
                ? Image.memory(_image!, height: 200)
                : Icon(Icons.person_outline, size: 200),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: selectImageFromGallery,
                  icon: Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: Color.fromARGB(218, 250, 78, 65),
                  ),
                ),
                IconButton(
                  onPressed: selectImageFromCamera,
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                    color: Color.fromARGB(218, 250, 78, 65),
                  ),
                ),
              ],
            ),
            SizedBox(height: 17),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(218, 250, 78, 65),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
