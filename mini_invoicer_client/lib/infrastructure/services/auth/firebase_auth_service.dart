import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth _firebaseAuth;
  FirebaseAuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      // REF: When enabling email sign in, create a user with
      // these following credentials:
      // emai:      slick@dope.com
      // password:  Supercoolbeans123!
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (exception) {
      return exception.message;
    }
  }

  Future<String> signUpWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed Up';
    } on FirebaseAuthException catch (exception) {
      return exception.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
