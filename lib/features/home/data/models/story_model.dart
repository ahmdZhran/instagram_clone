class StoryModel {
  final String id;
  final String userId;
  final String mediaUrl;
  final StoryType type;
  final DateTime createdAt;
  final Duration duration;

  StoryModel({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.type,
    required this.createdAt,
    required this.duration,
  });
}

enum StoryType { image, video }