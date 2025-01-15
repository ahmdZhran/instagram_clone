import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String? description;
  final String username;
  final String imageUrl;
  final String? deviceToken;
  final String userProfileImage;
  final List<String> likes;
  final DateTime timestamp;

  PostModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.username,
    required this.imageUrl,
    this.deviceToken,
    required this.timestamp,
    required this.likes,
    required this.userProfileImage,
  });

  PostModel copyWith({String? imageUrl, List<String>? likes}) {
    return PostModel(
      id: id,
      likes: likes ?? this.likes,
      userId: userId,
      deviceToken: deviceToken,
      username: username,
      description: description,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp,
      userProfileImage: userProfileImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': username,
      'id': id,
      'userId': userId,
      'likes': likes,
      'device_token':deviceToken,
      "description": description,
      "imageUrl": imageUrl,
      "timestamp": Timestamp.fromDate(timestamp),
      "user_profile_image": userProfileImage,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      likes: List<String>.from(json['likes'] ?? []),
      description: json['description'],
      userId: json['userId'],
      username: json['user_name'],
      deviceToken: json['device_token'],
      imageUrl: json['imageUrl'],
      timestamp: json['timestamp'].toDate(),
      userProfileImage: json['user_profile_image'],
    );
  }
}
