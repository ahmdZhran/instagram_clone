class UserProfileEntity {
  final String uid;
  final String username;
  final String bio;
  final String profileImageUrl;
  final String name;
  final int? followers;
  final int? following;

  UserProfileEntity({
    required this.name,
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
     this.followers,
     this.following,
  });

  UserProfileEntity copyWith({
    String? name,
    String? uid,
    String? username,
    String? bio,
    String? profileImageUrl,
    int? followers,
    int? following,
  }) {
    return UserProfileEntity(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
