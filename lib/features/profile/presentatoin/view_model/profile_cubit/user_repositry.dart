import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/prfile_model.dart';

class UserRepositry {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserProfile> getUserDetails() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final doc =
        await _firestore.collection("users").doc(currentUser!.uid).get();
    final data = doc.data() as Map<String, dynamic>;

    return UserProfile(
      email: data['email'],
      userName: data['user_name'],
      bio: data['bio'],
      name: data['name'],
    );
  }
}
