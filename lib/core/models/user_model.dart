class UserModel {
  final String name;
  final String username;
  final String email;
  final String password;
  final String bio;
  final String imageUrl;
  final String uid;
  final List? following;
  final List? follower;

  UserModel({
    required this.name,
    required this.uid,
    required this.follower,
    required this.following,
    required this.username,
    required this.email,
    required this.password,
    required this.bio,
    required this.imageUrl,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "bio": bio,
        "imageUrl": imageUrl,
        "uid": uid,
        "following": following,
        "follower": follower,
      };
}
