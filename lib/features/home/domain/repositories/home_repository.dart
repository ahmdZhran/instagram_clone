import '../../../posts/domain/entities/post_entity.dart';
import '../entities/comment_entity/comment_entity.dart';

abstract class HomeRepository {
  Future<Stream<List<PostEntity>>> fetchAllPosts();
  Future<void> toggleLikedPost(String postID, String userID);
  Future<void> addComment(String postId, CommentEntity commentEntity);
  Future<Stream<List<CommentEntity>>> fetchComments();
}
