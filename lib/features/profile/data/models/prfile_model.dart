class UserProfile {
  final String? email;
  final String? userName;
  final String? name;
  final String? bio;
  final String? profileImageUrl;
  final List<String>? followers;
  final List<String>? following;

  UserProfile({
    this.email,
    this.userName,
    this.name,
    this.bio,
    this.followers,
    this.following,
    this.profileImageUrl,
  });
}
