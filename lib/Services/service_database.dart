import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBProvider {
  main();
  Stream<QuerySnapshot> getHistory();
  Future<DocumentSnapshot> getProfile(String userId);
  Stream<DocumentSnapshot> alarm();
  setIsActive(bool isActive);
}

class DataBase implements DBProvider {
  FirebaseFirestore databaseReference;

  main() async {
    print("Opening connection ...");
    databaseReference = FirebaseFirestore.instance;
    print("Opened connection!");
  }

  Stream<QuerySnapshot> getHistory() {
    return databaseReference
        .collection("alarms")
        .doc("XkG3PST8SI5fyVcve0Zq")
        .snapshots();
  }

  Future<DocumentSnapshot> getProfile(String userId) {
    return databaseReference.collection("users").doc(userId).get();
  }

  Stream<DocumentSnapshot> alarm() {
    return databaseReference
        .collection("alarms")
        .doc("xshiCmkPvzXIfBCHiju3")
        .snapshots();
  }

  setIsActive(bool isActive) {
    databaseReference
        .collection("alarms")
        .doc("xshiCmkPvzXIfBCHiju3")
        .update({"isActive": isActive});
  }

  activeAlarm() {}
}
