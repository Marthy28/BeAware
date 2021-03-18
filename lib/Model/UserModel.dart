import 'package:be_aware/Util/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  User _user;
  DateTime _signInOn;
  User get user => _user;
  DateTime get signInOn => _signInOn;
  String get displayName => user.isAnonymous ? "invite" : user.displayName;

  void signIn(User user) {
    _user = user;
    _signInOn = DateTime.now();
    provider.setLastConnexion(user);
    provider.setProfilInfo(user);
    //notifyListeners();
  }
}
