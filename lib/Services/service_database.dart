import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBProvider {
  main();
}

class DataBase implements DBProvider {
  FirebaseFirestore databaseReference;

  main() async {
    print("Opening connection ...");
    databaseReference = FirebaseFirestore.instance;
    print("Opened connection!");
  }
}
