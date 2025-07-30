import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({required String email, required String password}) async{
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      return 'success';
      
    } on FirebaseAuthException catch (e) {
      return 'Login failed: ${e.message}';
    } catch (e) {
      return 'An unexpected error occurried: ${e.toString()}';
    }
  }

  Future<String> signUpUser({
    required String email, 
    required String password, 
    required String username, 
    Uint8List? file
    }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      User? user = userCredential.user;

      if (user != null) {
        Users users = Users(
          uid: user.uid, 
          email: email, 
          username: username, 
          bio: '', 
          photoUrl: '', 
          followers: [], 
          following: [], 
          posts: [], 
          saved: [], 
          searchKey: username.toLowerCase(),
          );

          await _firestore.collection("users").doc(user.uid).set(users.toJson());

          return 'success';
      } else {
        return 'Failed to create user';
      }
    } on FirebaseAuthException catch (e) {
      return 'Sign up failed: ${e.message}';
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  Future<Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot = await _firestore
      .collection('users')
      .doc(currentUser.uid)
      .get();

    return Users.fromSnap(documentSnapshot);
  }
}