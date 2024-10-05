import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/firebase_auth_errors_handler.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  AuthRepository({
    required this.auth,
    required this.firestore,
    required this.firebaseStorage,
  });

  Future<Either<String, User?>> createUserWithEmailAndPassword({
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
      return Right(userCredential.user);
    } on FirebaseAuthException catch (error) {
      return Left(FirebaseAuthErrorHandler.getErrorMessage(error.code));
    }
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

  Future<Either<String, void>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(FirebaseAuthErrorHandler.getErrorMessage(error.code));
    }
  }

  Future<Either<String, void>> resetPasswordWithEmail({
    required String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(FirebaseAuthErrorHandler.getErrorMessage(error.code));
    }
  }

  Future<Either<String, void>> verifyEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }
}
