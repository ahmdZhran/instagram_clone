import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  AuthRepository({
    required this.auth,
    required this.firestore,
    required this.firebaseStorage,
  });

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String name,
    required String bio,
    required Uint8List? profileImage,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String imageUrl =
          await _uploadProfileImage(profileImage!, userCredential.user!.uid);

      await firestore.collection('users').doc(userCredential.user!.uid).set({
        "username": username,
        "name": name,
        "bio": bio,
        "profileImage": imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
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
      throw (errorMessage);
    }
    return null;
  }

  Future<String> _uploadProfileImage(Uint8List image, String userId) async {
    try {
      TaskSnapshot snapshot = await firebaseStorage
          .ref()
          .child('profileImages/$userId')
          .putData(image);
      return await snapshot.ref.getDownloadURL();
    } catch (error) {
      debugPrint('error to upload image profile$error');
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
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
      await auth.sendPasswordResetEmail(email: email);
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

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }
}
