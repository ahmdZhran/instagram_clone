import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserModel {
  final String uid;
  final String username;
  final String name;
  final String bio;
  final String profileImageUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      username: doc['username'],
      name: doc['name'],
      bio: doc['bio'],
      profileImageUrl: doc['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'username': username,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      name: json['name'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      uid: uid,
      username: username,
      name: name,
      bio: bio,
      profileImageUrl: profileImageUrl,
    );
  }

  factory UserModel.fromEntity(UserProfileEntity entity) {
    return UserModel(
      uid:entity.uid,
      username: entity.username,
      name: entity.name,
      bio: entity.bio,
      profileImageUrl: entity.profileImageUrl,
    );
  }
}
