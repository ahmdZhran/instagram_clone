class UserModel {
  final String name;
  final String username;
  final String email;
  final String passowrd;
  final String bio;
  final String imageUrl;

  UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.passowrd,
    required this.bio,
    required this.imageUrl,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "password": passowrd,
        "bio": bio,
        "imageUrl": imageUrl,
      };
}
