
class UserProfileEntity {
  final String uid;
  final String name;
  final String username;
  final String bio;
  final String profileImageUrl;
  final String? followers;
  final String? following;


  UserProfileEntity({
    required this.name,
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
     this.followers,
     this.following,
  });


}
