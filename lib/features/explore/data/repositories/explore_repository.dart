import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/search_user_model.dart';

class ExploreRepository {
  Future<List<SearchUserModel>> searchUsers(String username) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("user_name", isEqualTo: username)
          .get();

      return querySnapshot.docs
          .map((doc) => SearchUserModel.fromFirestore(doc.data()))
          .toList();
    } catch (error) {
      throw Exception("Failed to search users :$error");
    }
  }
}
