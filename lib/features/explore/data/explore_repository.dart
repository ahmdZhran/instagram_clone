import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/explore/domain/entities/user_entity.dart';

class ExploreRepository {
  Future<List<UserEntity>> searchUsers(String username) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("user_name", isEqualTo: username)
          .get();

      return querySnapshot.docs
          .map((doc) => UserEntity.fromFirestore(doc.data()))
          .toList();
    } catch (error) {
      throw Exception("Failed to search users :$error");
    }
  }
}
