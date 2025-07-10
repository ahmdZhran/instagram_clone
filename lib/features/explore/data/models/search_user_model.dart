class SearchUserModel {
  final String username;
  final String profileImage;
  final String? uid;

  SearchUserModel({
    required this.username,
    required this.profileImage,
    this.uid,
  });

  factory SearchUserModel.fromFirestore(Map<String, dynamic> data) {
    return SearchUserModel(
      username: data['user_name'] ?? '',
      profileImage: data['profile_image'] ?? '',
      uid: data['uid'] ?? '',
    );
  }
}
