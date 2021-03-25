import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DBProvider {
  main();
  Future<bool> setLastConnexion(User user);
  Future<bool> setProfilInfo(User user);
  Future<void> setAlarmToProfil(String alarmId, String userId);
  Stream<QuerySnapshot> getHistory();
  Future<DocumentSnapshot> getProfilInfo(String profile);
  Future<DocumentSnapshot> getProfile(String userId);
  Stream<DocumentSnapshot> alarm(String alarmId);
  Stream<QuerySnapshot> usersAlarm(String userId);
  setIsActive(bool isActive);
}

class DataBase implements DBProvider {
  FirebaseFirestore databaseReference;

  Stream<QuerySnapshot> getHistory() {
    return databaseReference
        .collection("alarms")
        .doc("xshiCmkPvzXIfBCHiju3")
        .collection("history")
        .snapshots();
  }

  main() async {
    print("Opening connection ...");
    databaseReference = FirebaseFirestore.instance;
    print("Opened connection!");
  }

  Stream<QuerySnapshot> getHistory() {
    return databaseReference
        .collection("alarms")
        .doc("xshiCmkPvzXIfBCHiju3")
        .collection("history")
        .snapshots();
  }

  Future<DocumentSnapshot> getProfile(String userId) {
    return databaseReference.collection("users").doc(userId).get();
  }

  Future<bool> setLastConnexion(User user) {
    DateTime dateTime = DateTime.now();
    databaseReference.collection('users').doc(user.uid).set(
        {'last_connexion': dateTime}, SetOptions(merge: true)).then((value) {
      return Future<bool>.value(true);
    });
    return Future<bool>.value(true);
  }

  Future<bool> setProfilInfo(User user) {
    DateTime dateTime = DateTime.now(); //Pour premiere connexion
    String firstName = user.displayName;
    String lastName = "";
    if (user != null &&
        user.displayName != null &&
        user.displayName.contains(" ")) {
      var fullname = user.displayName.split(" ");
      firstName = fullname[0];
      lastName = fullname[1];
    }

    databaseReference.collection('users').doc(user.uid).set({
      'firstName': user.isAnonymous ? "invite" : firstName,
      'lastName': user.isAnonymous ? "" : lastName,
    }, SetOptions(merge: true)).then((_) {
      return Future<bool>.value(true);
    });

    return Future<bool>.value(true);
  }

  Future<void> setAlarmToProfil(String alarmId, String userId) async {
    var alarms = await databaseReference
        .collection('alarms')
        .where('code_activation', isEqualTo: alarmId)
        .get();

    if (alarms == null || alarms.docs == null || alarms.docs.length == 0)
      return;

    var users = alarms.docs.first.data()["users"] as List<dynamic>;

    if (!users.contains(userId)) {
      print("Alarm add");
      databaseReference.collection('alarms').doc(alarms.docs.first.id).update({
        "users": FieldValue.arrayUnion([userId])
      });
    }
  }

  Future<DocumentSnapshot> getProfilInfo(String profile) {
    return databaseReference.collection("users").doc(profile).get();
  }

  Stream<DocumentSnapshot> alarm(String alarmId) {
    if (alarmId == null) return null;

    print(alarmId);
    return databaseReference.collection("alarms").doc(alarmId).snapshots();
  }

  setIsActive(bool isActive) {
    databaseReference
        .collection("alarms")
        .doc("xshiCmkPvzXIfBCHiju3")
        .update({"isActive": isActive});
  }

  Stream<QuerySnapshot> usersAlarm(String userId) {
    return databaseReference
        .collection("alarms")
        .where("users", arrayContains: userId)
        .snapshots();
  }
}
