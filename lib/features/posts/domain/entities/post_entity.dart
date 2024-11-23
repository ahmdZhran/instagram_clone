import 'package:cloud_firestore/cloud_firestore.dart';

class PostEntity {
  final String id;
  final String userId;
  final String? description;
  final String username;
  final String imageUrl;
  final String userProfileImage;
  final List likes;
  final DateTime timestamp;

  PostEntity({
    required this.id,
    required this.userId,
    required this.description,
    required this.username,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.userProfileImage,
  });

  PostEntity copyWith({String? imageUrl}) {
    return PostEntity(
      id: id,
      likes: likes,
      userId: userId,
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
      "description": description,
      "imageUrl": imageUrl,
      "timestamp": timestamp.millisecondsSinceEpoch, 
      "user_profile_image": userProfileImage,
    };
  }

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    final timestampField = json['timestamp'];
    DateTime timestamp;

    if (timestampField is Timestamp) {
      timestamp = timestampField.toDate();
    } else if (timestampField is int) {
      timestamp = DateTime.fromMillisecondsSinceEpoch(timestampField);
    } else {
      throw Exception('Unexpected timestamp format: $timestampField');
    }

    return PostEntity(
      id: json['id'],
      likes: List.from(json['likes']),
      description: json['description'],
      userId: json['userId'],
      username: json['user_name'],
      imageUrl: json['imageUrl'],
      timestamp: timestamp,
      userProfileImage: json['user_profile_image'],
    );
  }
}
