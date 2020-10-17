import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
}

class Auth implements BaseAuth {
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return "123456";
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return null;
  }

  Future<String> currentUser() async {
    User user = FirebaseAuth.instance.currentUser;
    return user.uid;
  }
}
