import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String> uploadImagesToFireStorage(
      Uint8List imageData, String userId, String folderName) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child(folderName).child(userId);
      final uploadTask = await storageRef.putData(imageData);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
