import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/reels/data/models/reel_model.dart';

class ReelsRepository {
  final CollectionReference reelsCollection =
      FirebaseFirestore.instance.collection("Reels");

  Future<Stream<List<ReelModel>>> getAllReels() async {
    try {
      return reelsCollection
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map(
                (doc) => ReelModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      throw Exception("Error fetching reels: $error");
    }
  }
}
