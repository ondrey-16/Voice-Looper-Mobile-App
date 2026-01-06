import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocal_looper_app/models/user.dart';
import '../auth/auth_service.dart';

class UserService {
  final FirebaseFirestore _db;
  final AuthService _auth;

  const UserService(FirebaseFirestore db, AuthService auth)
    : _db = db,
      _auth = auth;

  Stream<UserData?> get userStream {
    final userID = _auth.user?.uid;
    if (userID == null) return Stream.value(null);

    return _db.collection('users').doc(userID).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return null;
      }
      return UserData.fromJson(data);
    });
  }

  Future<void> addUser(String userID, UserData user) {
    return _db
        .collection('users')
        .doc(userID)
        .set(user.toJson(), SetOptions(merge: true));
  }
}
