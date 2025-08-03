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
        title: Text('Add New '),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _captionController,
              decoration: InputDecoration(
                hintText: 'Write a caption...',
              ),
              maxLines: 4,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey.shade300,
            child: _file != null 
              ? Image.memory(_file!, fit: BoxFit.cover)
              : Image.asset('assets/images/add.webp', width: 50, height: 50,)
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                print('Seleccionar imagen');
              }, 
              child: Text('Select Image'),
              ),
          ),
        ],
      ),
    );
  }
}