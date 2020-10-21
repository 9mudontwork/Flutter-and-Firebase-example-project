import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_example/models/user.dart' as model;

// handle exception
// https://medium.com/flutter-community/firebase-auth-exceptions-handling-flutter-54ab59c2853d

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

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      firebase.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      firebase.User firebaseUser = userCredential.user;

      return _userFromFirebaseUser(firebaseUser);
    } on firebase.FirebaseAuthException catch (e) {
      print('error จาก firebase: ${e.code}');
      print(e.message);
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      firebase.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      firebase.User firebaseUser = userCredential.user;

      return _userFromFirebaseUser(firebaseUser);
    } on firebase.FirebaseAuthException catch (e) {
      print('error จาก firebase: ${e.code}');
      print(e.message);
      return null;
    } catch (e) {
      print(e.toString());
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
