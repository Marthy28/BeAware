import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<User> signIn(String email, String password);
  Future<String> signUp(String email, String password, String displayName);
  Future<User> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signIn(String email, String password) async {
    User currentUser;
    //UserCredential result =
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    //final User user = result.user;
    currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  Future<String> signUp(
      String email, String password, String displayName) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    /*UserUpdateInfo updateInfo = new updateProfile ();
    updateInfo.displayName = displayName;*/
    result.user.updateProfile(displayName: displayName);
    User user = result.user;
    return user.uid;
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
