import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import '../../models/user_post_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  UserRemoteDataSource(this._firebaseFirestore);

  Future<UserModel> getUserProfile(String userId) async {
    var doc = await _firebaseFirestore.collection("users").doc(userId).get();
    return UserModel.fromDocument(doc);
  }

  Future<UserModel> updateUserProfile(
      String userId, UserModel userModel) async {
    await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .update(userModel.toJson());

    var updatedDoc =
        await _firebaseFirestore.collection("users").doc(userId).get();
    return UserModel.fromDocument(updatedDoc);
  }

   Future<List<UserPostModel>> getUserPosts(String uid) async {
    var querySnapshot = await _firebaseFirestore
        .collection('posts')
        .where('userId', isEqualTo: uid) 
        .get();

    List<UserPostModel> posts = querySnapshot.docs
        .map((doc) => UserPostModel.fromDocument(doc))
        .toList();

    return posts;
  }
}
