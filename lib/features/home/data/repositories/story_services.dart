import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/features/home/data/models/story_model.dart';

class StoryService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> uploadStory(File file, String userId) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child('stories/$userId/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      await _firestore.collection('stories').add({
        'imageUrl': downloadUrl,
        'userId': userId,
        'timestamp': Timestamp.now(),
      });

      return downloadUrl;
    } catch (e) {
      print('Error uploading story: $e');
      return null;
    }
  }

  Future<List<StoryModel>> fetchStories() async {
    QuerySnapshot snapshot = await _firestore
        .collection('stories')
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => StoryModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
