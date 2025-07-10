import 'package:cloud_firestore/cloud_firestore.dart';

class ReelModel {
  final String id;
  final String userId;
  final String? description;
  final String username;
  final String videoUrl;
  final String? deviceToken;
  final String userProfileImage;
  final List<String> likes;
  final DateTime timestamp;

  ReelModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.username,
    required this.videoUrl,
    this.deviceToken,
    required this.timestamp,
    required this.likes,
    required this.userProfileImage,
  });

  ReelModel copyWith({String? imageUrl, List<String>? likes}) {
    return ReelModel(
      id: id,
      likes: likes ?? this.likes,
      userId: userId,
      deviceToken: deviceToken,
      username: username,
      description: description,
      videoUrl: videoUrl,
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
      'device_token': deviceToken,
      "description": description,
      "videoUrl": videoUrl,
      "timestamp": Timestamp.fromDate(timestamp),
      "user_profile_image": userProfileImage,
    };
  }

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'],
      likes: List<String>.from(json['likes'] ?? []),
      description: json['description'],
      userId: json['userId'],
      username: json['user_name'],
      deviceToken: json['device_token'],
      videoUrl: json['imageUrl'],
      timestamp: json['timestamp'].toDate(),
      userProfileImage: json['user_profile_image'],
    );
  }
}
