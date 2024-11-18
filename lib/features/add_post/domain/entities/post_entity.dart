import 'package:cloud_firestore/cloud_firestore.dart';

class PostEntity {
  final String id;
  final String userId;
  final String? description;
  final String userName;
  final String imageUrl;
  final List likes;
  final DateTime timesTamp;

  PostEntity({
    required this.id,
    required this.userId,
    required this.description,
    required this.userName,
    required this.imageUrl,
    required this.timesTamp,
    required this.likes,
  });

  PostEntity copyWith({String? imageUrl}) {
    return PostEntity(
      id: id,
      likes: likes,
      userId: userId,
      userName: userName,
      description: description,
      imageUrl: imageUrl ?? this.imageUrl,
      timesTamp: timesTamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'likes' : likes,
      'username': userName,
      "description": description,
      "imageUrl": imageUrl,
      "timesTamp": Timestamp.fromDate(timesTamp),
    };
  }

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'],
      likes: json['likes'],
      description: json['description'],
      userId: json['userId'],
      userName: json['username'],
      imageUrl: json['imageUrl'],
      timesTamp: json['timesTamp'].toDate(),
    );
  }
}
