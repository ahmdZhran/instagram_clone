import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/core/models/user_model.dart';

import '../../../../core/services/firebase_services/storage.dart';
import 'auth_repositry.dart';


class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> signUpWithEmailAndPassword(UserModel userModel, Uint8List profileImage) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );

      final imageUrl = await StorageMethod().uploadImageToStorage('profileImage', profileImage, false);

      final user = UserModel(
        name: userModel.name,
        username: userModel.username,
        email: userModel.email,
        password: userModel.password,
        bio: userModel.bio,
        imageUrl: imageUrl,
        uid: userCredential.user!.uid,
        follower: [],
        following: [],
      );

      await _firestore.collection("users").doc(user.uid).set(user.toJson());

      await verifyEmail();
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  @override
  Future<void> resetPasswordWithEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Reset password failed: $e');
    }
  }

  @override
  Future<void> verifyEmail() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }
}
