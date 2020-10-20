import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_firebase_example/models/user.dart' as model;

class AuthService {
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;

  model.User _userFromFirebaseUser(firebase.User user) {
    return user != null ? model.User(uid: user.uid) : null;
  }

  Stream<model.User> get user {
    return _firebaseAuth
        .authStateChanges()
        // .map((firebase.User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  Future signInAnonymouse() async {
    try {
      firebase.UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      firebase.User firebaseUser = userCredential.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
