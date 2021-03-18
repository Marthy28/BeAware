import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<User> signIn(String email, String password);
  Future<List> fullSignUp(
      String email, String password, String firstName, String lastName);
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

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  ///
  /// FullSignUpPicture est utilisée pour l'inscription sans image
  ///
  @override
  Future<List> fullSignUp(
      String email, String password, String firstName, String lastName) async {
    var res = new List(2);
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String fullName;
      fullName = firstName + " " + lastName;
      result.user.updateProfile(displayName: fullName, photoURL: null);
      User user = result.user;
      print('User : $user');
      res[0] = user.uid;
      return res;
    } catch (e) {
      print('Error: $e');
      res[1] = e;
      return res;
    }
  }
}
