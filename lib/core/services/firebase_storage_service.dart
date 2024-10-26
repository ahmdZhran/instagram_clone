import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageService {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageService({required this.firebaseStorage});

  Future<String> uploadProfileImage(Uint8List image, String userId) async {
    try {
      TaskSnapshot snapshot = await firebaseStorage
          .ref()
          .child('profileImages/$userId')
          .putData(image);
      return await snapshot.ref.getDownloadURL();
    } catch (error) {
      debugPrint('Error uploading profile image: $error');
      rethrow;
    }
  }
}
