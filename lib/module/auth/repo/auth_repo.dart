import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  //firebase initialization
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //user sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info if it does not already exists
      _firebaseFirestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // user sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //user signup with email and password
  Future<UserCredential> signupWithEmailPassword(
      String email, password, String fullName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //save user info in a separate doc
      _firebaseFirestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'fullName': fullName,
      });
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}
