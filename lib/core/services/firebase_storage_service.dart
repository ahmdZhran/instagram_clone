import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String> uploadProfileImage(
      Uint8List imageData, String userId) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profileImages').child(userId);
      final uploadTask = await storageRef.putData(imageData);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
