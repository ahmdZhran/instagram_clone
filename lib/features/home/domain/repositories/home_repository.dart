import 'package:instagram_clone/features/home/domain/entities/comment_enitity/comment_entity.dart';

import '../../../posts/domain/entities/post_entity.dart';

abstract class HomeRepository {
  Future<Stream<List<PostEntity>>> fetchAllPosts();
  Future<void> toggleLikedPost(String postID, String userID);
  Future<void> addComment(String postId, CommentEntity commentEntity);
}
