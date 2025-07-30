import 'package:flutter/material.dart';
import '../models/user.dart';
import '../methods/auth_methods.dart';

class  UserProvider with ChangeNotifier{
  Users? _user;
  final AuthMethods _authMethods = AuthMethods(); 


  Users? get user => _user;

  Future<void> refreshUser() async {
    Users user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}