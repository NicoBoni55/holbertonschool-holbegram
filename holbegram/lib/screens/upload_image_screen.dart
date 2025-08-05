import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/home.dart';

class AddPicture extends StatefulWidget {
  final String? email;
  final String? password;
  final String? username;

  AddPicture({
    super.key,
    required this.email,
    required this.username,
    required this.password,
    });

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

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
      appBar: AppBar(),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, ${widget.username} to Holbegram.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Choose an image from your gallery or tak a new one.",
                    style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 28,)
                ],
              ),
            ),
            _image != null
                ? ClipOval(
                  child: Image.memory(
                    _image!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                )
                : Image.asset(
                  'assets/images/default_user.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
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
                onPressed: () async {
                  String result = await AuthMethods().signUpUser(
                    email: widget.email!, 
                    password: widget.password!, 
                    username: widget.username!,
                    file: _image,
                  );

                  if (result == 'success') {
                    await Provider.of<UserProvider>(context).refreshUser();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Account created successfully!"),
                        backgroundColor: Colors.green,
                        )
                    );

                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => Home())
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result, style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.red,)
                    );
                  }
                },
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
