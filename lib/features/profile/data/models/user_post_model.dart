import 'package:cloud_firestore/cloud_firestore.dart';

class UserPostModel {
  final String postId;
  final String userId;
  final String postImageUrl;
  final String description;

  UserPostModel({
    required this.postId,
    required this.userId,
    required this.postImageUrl,
    required this.description,
  });

  factory UserPostModel.fromDocument(DocumentSnapshot doc) {
    return UserPostModel(
      postId: doc.id,
      userId: doc['userId'] ?? '',
      postImageUrl: doc['imageUrl'] ?? '',
      description: doc['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'imageUrl': postImageUrl,
      'description': description,
    };
  }
}
