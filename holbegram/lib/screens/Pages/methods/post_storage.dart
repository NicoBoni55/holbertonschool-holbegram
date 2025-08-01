import 'dart:typed_data';
import '../../auth/methods/user_storage.dart';
import '../../../models/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String caption, 
    String uid, 
    String username, 
    String profImage, 
    Uint8List image
  ) async {
    try {
      String postUrl = await StorageMethods().uploadImageToStorage(
        true, 
        'posts', 
        image
      );

      String postId = DateTime.now().microsecondsSinceEpoch.toString();

      Posts post = Posts(
        caption: caption, 
        uid: uid, 
        username: username, 
        likes: [], 
        postId: postId, 
        datePublished: DateTime.now(), 
        postUrl: postUrl, 
        profImage: profImage
      );

      await _firestore.collection('posts').doc(postId).set(post.toJson());

      return "Ok";
    } catch (e) {
      return e.toString();
    }
 }

 Future<void> deletePost(String postId, String publicId) async {
  try {
    await _firestore.collection('posts').doc(postId).delete();

  } catch (e) {
    throw e;
  }
 }
}