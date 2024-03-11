import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class UserRepositry {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future<UserModel> getUser(String documentId) async {
    final snapshot = await _usersCollection.doc(documentId).get();
    if (snapshot.exists) {
      final data = snapshot.data();

      return UserModel.fromMap(data as Map<String, dynamic>);
    } else {
      throw Exception("Document does not exist");
    }
  }

  // Future<void> upDateUser(UserModel userModel) async {
  //   await firestore.collection("users").doc(userModel.id).update({
  //     // "email": userModel.email,
  //     "user_name": userModel.username,
  //     "name": userModel.name,
  //     "bio": userModel.bio,
  //     // "following": userModel.following,
  //     // "follower": userModel.followers,
  //   });
  // }
}
