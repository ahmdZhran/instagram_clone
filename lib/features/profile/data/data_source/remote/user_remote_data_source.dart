import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

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
}
