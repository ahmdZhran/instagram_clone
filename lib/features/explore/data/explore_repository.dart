import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreRepository {
  Future<QuerySnapshot<Map<String, dynamic>>> searchUsers(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("user_name", isEqualTo: username)
        .get();
  }
}
