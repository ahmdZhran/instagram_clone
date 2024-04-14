class UserModel {
  final String name;
  final String username;
  final String email;
  final String password;
  final String bio;
  String? imageUrl;
  final String uid;
  List? following;
  List? follower;

  UserModel({
    required this.name,
    required this.uid,
    this.follower,
    this.following,
    required this.username,
    required this.email,
    required this.password,
    required this.bio,
    this.imageUrl,
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
