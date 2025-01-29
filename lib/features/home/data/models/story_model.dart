import 'package:googleapis/androidpublisher/v3.dart';

class StoryModel {
  final String id;
  final String imageUrl;
  final String userId;
  final Timestamp timestamp;

  StoryModel({
    required this.id,
    required this.imageUrl,
    required this.userId,
    required this.timestamp,
  });

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: map['id'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}
