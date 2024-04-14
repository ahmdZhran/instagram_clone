import 'dart:ffi';
import 'dart:typed_data';

import 'package:instagram_clone/core/models/user_model.dart';

abstract class AuthRepositry {
  Future<Void> signUpWithEmailAndPassword(
      UserModel userModel, Uint8List profileImage);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> resetPasswordWithEmail(String email);
  Future<void> verifyEmail();
}
