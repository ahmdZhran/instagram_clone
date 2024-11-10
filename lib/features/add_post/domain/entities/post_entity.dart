import 'package:cloud_firestore/cloud_firestore.dart';

class PostEntity {
  final String id;
  final String userId;
  final String? description;
  final String userName;
  final String imageUrl;
  final DateTime timesTamp;

  PostEntity({
    required this.id,
    required this.userId,
    required this.description,
    required this.userName,
    required this.imageUrl,
    required this.timesTamp,
  });

  PostEntity copyWith({String? imageUrl}) {
    return PostEntity(
      id: id,
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
      'name': userName,
      "description": description,
      "imageUrl": imageUrl,
      "timesTamp": Timestamp.fromDate(timesTamp),
    };
  }

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'],
      description: json['description'],
      userId: json['userId'],
      userName: json['name'],
      imageUrl: json['imageUrl'],
      timesTamp: json['timesTamp'].toDate(),
    );
  }
}
