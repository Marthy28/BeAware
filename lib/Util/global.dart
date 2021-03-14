import 'dart:ui';

import 'package:be_aware/Services/service_authentification.dart';
import 'package:be_aware/Services/service_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

DBProvider _provider;
BaseAuth _auth;
User _firebaseUser;
VoidCallback _logoutCallback;

BuildContext _buildContext;

DBProvider get provider {
  if (_provider == null) {
    _provider = new DataBase();
    _provider.main();
  }
  return _provider;
}

BaseAuth get auth {
  if (_auth == null) {
    _auth = new Auth();
  }
  return _auth;
}

set auth(BaseAuth value) {
  auth = value;
}

User get firebaseUser {
  return _firebaseUser;
}

set firebaseUser(User user) {
  _firebaseUser = user;
}

VoidCallback get logoutCallback {
  return _logoutCallback;
}

set logoutCallback(VoidCallback callback) {
  _logoutCallback = callback;
}

BuildContext get buildContext {
  return _buildContext;
}

set buildContext(BuildContext context) {
  _buildContext = context;
}
