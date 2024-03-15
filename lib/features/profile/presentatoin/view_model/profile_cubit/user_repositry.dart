import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/prfile_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserRepositry {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserProfile> getUserDetails() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final doc =
        await _firestore.collection("users").doc(currentUser!.uid).get();
    final data = doc.data() as Map<String, dynamic>;

    return UserProfile(
      email: data['email'],
      userName: data['user_name'],
      bio: data['bio'],
      name: data['name'],
    );
  }

  Future<void> uploadProfileImage(String imagePath) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('User not logged in');
      }

      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_profile_images')
          .child('${currentUser.uid}.jpg');

      await ref.putFile(File(imagePath));

      final imageUrl = await ref.getDownloadURL();

      // Update user profile with image URL
      await _firestore.collection("users").doc(currentUser.uid).update({
        'profileImageUrl': imageUrl,
      });
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }
}
