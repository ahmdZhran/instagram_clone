class CommentEntity {
  final String commentId;
  final String profilePic;
  final String username;
  final String commentText;
  final DateTime dateOfComment;
  final String uid;

  CommentEntity({
    required this.commentId,
    required this.profilePic,
    required this.username,
    required this.commentText,
    required this.dateOfComment,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'profilePic': profilePic,
      'username': username,
      'commentText': commentText,
      'dateOfComment': dateOfComment.toIso8601String(),
      'uid': uid,
    };
  }

  factory CommentEntity.fromMap(Map<String, dynamic> map) {
    return CommentEntity(
      commentId: map['commentId'],
      profilePic: map['profilePic'],
      username: map['username'],
      commentText: map['commentText'],
      dateOfComment: DateTime.parse(map['dateOfComment']),
      uid: map['uid'],
    );
  }
}
