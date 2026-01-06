import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocal_looper_app/auth/auth_cubit.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(FirebaseAuth firebaseAuth) : _firebaseAuth = firebaseAuth;

  bool get isSignedIn => _firebaseAuth.currentUser != null;
  String? get userEmail => _firebaseAuth.currentUser?.email;
  User? get user => _firebaseAuth.currentUser;

  Stream<bool> get isSignedInStream =>
      _firebaseAuth.userChanges().map((user) => user != null);

  AuthState get stateFromAuth => isSignedIn
      ? SignedInState(email: _firebaseAuth.currentUser?.email ?? '')
      : SignedOutState();

  Future<String?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> deleteUser() async {
    await user?.delete();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
