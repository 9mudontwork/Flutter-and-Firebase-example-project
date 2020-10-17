import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_example/models/user.dart' as model;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  model.User _userFromFirebaseUser(User user) {
    return user != null ? model.User(uid: user.uid) : null;
  }

  Future signInAnonymouse() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
