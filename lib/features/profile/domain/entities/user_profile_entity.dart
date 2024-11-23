import '../../../posts/domain/entities/post_entity.dart';

class UserProfileEntity {
  final String uid;
  final String name;
  final String username;
  final String bio;
  final String profileImageUrl;

  // Optional: Include posts
  final List<PostEntity>? userPosts;

  UserProfileEntity({
    required this.name,
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
    this.userPosts,
  });

  UserProfileEntity copyWith({List<PostEntity>? userPosts}) {
    return UserProfileEntity(
      uid: uid,
      name: name,
      username: username,
      bio: bio,
      profileImageUrl: profileImageUrl,
      userPosts: userPosts ?? this.userPosts,
    );
  }
}
