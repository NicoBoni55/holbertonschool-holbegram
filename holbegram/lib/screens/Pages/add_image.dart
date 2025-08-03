import 'package:flutter/material.dart';
import 'dart:typed_data';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? _file;
  final TextEditingController _captionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Image', 
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Center(
            child: Text(
              'Post',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Billabong',
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Add Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Choose an image from your gallery or take a one.',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _captionController,
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 200,
            width: double.infinity,
            child: _file != null
                ? Image.memory(_file!, fit: BoxFit.cover)
                : Image.asset('assets/images/add.webp', width: 50, height: 50),
          ),
        ],
      ),
    );
  }
}
