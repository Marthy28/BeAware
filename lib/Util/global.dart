import 'dart:ui';

import 'package:be_aware/Services/service_authentification.dart';
import 'package:be_aware/Services/service_database.dart';
import 'package:be_aware/Services/service_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

DBProvider _provider;
BaseAuth _auth;
User _firebaseUser;
VoidCallback _logoutCallback;

BuildContext _buildContext;
StorageProvider _storageProvider;
DBProvider get provider {
  if (_provider == null) {
    _provider = new DataBase();
    _provider.main();
  }
  return _provider;
}

StorageProvider get storageProvider {
  if (_storageProvider == null) {
    _storageProvider = new Storage();
    _storageProvider.main();
  }
  return _storageProvider;
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
