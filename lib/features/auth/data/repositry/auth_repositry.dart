import 'package:flutter/foundation.dart';

import '../../../../core/models/user_model.dart';

abstract class AuthRepository {
  Future<void> signUpWithEmailAndPassword(UserModel userModel, Uint8List profileImage);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> resetPasswordWithEmail(String email);
  Future<void> verifyEmail();
}
