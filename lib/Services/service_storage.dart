import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

abstract class StorageProvider {
  main();
  Future<void> uploadFile(String id, String filePath);
}

class Storage implements StorageProvider {
  main() async {
    print("Opening connection ...");
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    print("Opened connection!");
  }

  Future<void> uploadFile(String id, String filePath) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('music/$id.mp3')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
}
