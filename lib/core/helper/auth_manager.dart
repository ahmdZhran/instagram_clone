import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;
  AuthManager._internal();

  String? userId;

  void initializeUserId() {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }
}
