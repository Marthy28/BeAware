import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBProvider {
  main();
  Future<DocumentSnapshot> getProfile(String userId);
  Stream<DocumentSnapshot> alarm();
  setIsActive(bool isActive);
  Future<List<DocumentSnapshot>> getHistory();
}

class DataBase implements DBProvider {
  FirebaseFirestore databaseReference;

  Stream<DocumentSnapshot> getHistory() {
    return databaseReference
        .collection("alarms")
        .doc("XkG3PST8SI5fyVcve0Zq")
        .snapshots();
  }

  main() async {
    print("Opening connection ...");
    databaseReference = FirebaseFirestore.instance;
    print("Opened connection!");
  }
}
