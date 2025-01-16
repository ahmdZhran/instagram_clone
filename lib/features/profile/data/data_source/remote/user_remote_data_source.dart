import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import '../../models/user_post_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  UserRemoteDataSource(this._firebaseFirestore);

  Future<UserProfileDataModel> getUserProfile(String userId) async {
    var doc = await _firebaseFirestore.collection("users").doc(userId).get();
    return UserProfileDataModel.fromDocument(doc);
  }

  Future<UserProfileDataModel> updateUserProfile(
      String userId, UserProfileDataModel userModel) async {
    await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .update(userModel.toJson());

    var updatedDoc =
        await _firebaseFirestore.collection("users").doc(userId).get();
    return UserProfileDataModel.fromDocument(updatedDoc);
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

  Future<void> followUser(String currentUserId, String targetUserId) async {
    await _firebaseFirestore.collection("users").doc(currentUserId).update({
      'following': FieldValue.arrayUnion([targetUserId])
    });

    await _firebaseFirestore.collection("users").doc(targetUserId).update({
      'followers': FieldValue.arrayUnion([currentUserId])
    });
  }

  Future<void> unFollowUser(String currentUserId, String targetUserId) async {
    await _firebaseFirestore.collection("users").doc(currentUserId).update({
      'following': FieldValue.arrayRemove([targetUserId])
    });

    await _firebaseFirestore.collection("users").doc(targetUserId).update({
      'followers': FieldValue.arrayRemove([currentUserId])
    });
  }
}
