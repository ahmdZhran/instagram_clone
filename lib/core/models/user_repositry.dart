import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/core/models/user_model.dart';

class UserRepositry {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String userId) async {
    DocumentSnapshot userSnapshot =
        await firestore.collection("users").doc(userId).get();
    return UserModel.fromFirestore(
        userSnapshot.data() as Map<String, dynamic>, userSnapshot.id);
  }

  Future<void> upDateUser(UserModel userModel) async {
    await firestore.collection("users").doc(userModel.id).update({
      "email": userModel.email,
      "user_name": userModel.username,
      "name": userModel.name,
      "bio": userModel.bio,
      "following": userModel.following,
      "follower": userModel.followers,
    });
  }
}
