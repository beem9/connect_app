import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth;

  AuthRepo(this._firebaseAuth);

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanged => _firebaseAuth.authStateChanges();

  Future<User?> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await saveUserInfoToFirebase(userCredential.user?.uid, userName,
          userCredential.user?.email, userCredential.user?.photoURL);

      return userCredential.user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) return null;

      final googleAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      await saveUserInfoToFirebase(
          userCredential.user?.uid,
          userCredential.user?.displayName,
          userCredential.user?.email,
          userCredential.user?.photoURL);

      return userCredential.user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future saveUserInfoToFirebase(
      String? uid, String? displayName, String? email, String? photoUrl) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "username": displayName,
        "email": email,
        "id": uid,
        "photo": photoUrl,
        "userLocation": null
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
