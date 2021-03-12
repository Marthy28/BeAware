import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DBProvider {
  main();
  Future<bool> setLastConnexion(User user);
  Future<bool> setProfilInfo(User user);
  Future<DocumentSnapshot> getProfilInfo(String profile);
  Future<DocumentSnapshot> getProfile(String userId);
  Stream<DocumentSnapshot> alarm();
  setIsActive(bool isActive);
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

  Future<DocumentSnapshot> getProfilInfo(String profile) {
    return databaseReference.collection("users").doc(profile).get();
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
