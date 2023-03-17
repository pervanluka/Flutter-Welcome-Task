import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  User? get isLogged => _firebaseAuth.currentUser;

  Future<User?> signUp({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
          return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  // Future<FirebaseUser> signInWithGoogle() async {
  //   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   await _firebaseAuth.signInWithCredential(credential);
  //   return _firebaseAuth.currentUser();
  // }

  // Future<void> signInWithCredentials(String email, String password) {
  //   return _firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  // Future<void> signUp({String email, String password}) async {
  //   return await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  // Future<void> signOut() async {
  //   return Future.wait([
  //     _firebaseAuth.signOut(),
  //     _googleSignIn.signOut(),
  //   ]);
  // }

  // Future<bool> isSignedIn() async {
  //   final currentUser = await _firebaseAuth.currentUser();
  //   return currentUser != null;
  // }

  // Future<String> getUser() async {
  //   return (await _firebaseAuth.currentUser()).email;
  // }
}
