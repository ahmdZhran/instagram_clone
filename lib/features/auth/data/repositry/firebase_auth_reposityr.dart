import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/models/user_model.dart';
import 'package:instagram_clone/core/services/firebase_services/storage.dart';

class AuthRepositry {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethod _storageMethod = StorageMethod();

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String name,
    required String bio,
    required Uint8List? profileImage,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String imageUrl = await _storageMethod.uploadImageToStorage(
        'profileImge',
        profileImage!,
        false,
      );
      UserModel userModel = UserModel(
        name: name,
        uid: userCredential.user!.uid,
        follower: [],
        following: [],
        username: username,
        email: email,
        password: password,
        bio: bio,
        imageUrl: imageUrl,
      );
      await _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email is invalid';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred';
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        default:
          errorMessage = 'An error occurred during sign in.';
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> resetPasswordWithEmail({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email.';
      } else {
        errorMessage = 'An error occurred while resetting password.';
      }
      throw Exception(errorMessage);
    }
  }
}
