import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBProvider {
  main();
  Future<List<DocumentSnapshot>> getHistory();
}

class DataBase implements DBProvider {
  FirebaseFirestore databaseReference;

  Future<List<DocumentSnapshot>> getHistory() async {
    QuerySnapshot snap = await databaseReference.collection('history').get();
    return snap.docs;
  }

  main() async {
    print("Opening connection ...");
    databaseReference = FirebaseFirestore.instance;
    print("Opened connection!");
  }
}
