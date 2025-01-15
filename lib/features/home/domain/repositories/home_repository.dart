import 'package:instagram_clone/features/posts/data/models/post_model.dart';
import '../entities/comment_entity/comment_entity.dart';

abstract class HomeRepository {
  Future<Stream<List<PostModel>>> fetchAllPosts();
  Future<void> toggleLikedPost(String postID, String userID);
  Future<void> addComment(String postId, CommentEntity commentEntity);
  Future<Stream<List<CommentEntity>>> fetchComments(String postId);
  Future<void> deleteComment(String postId, String commentId);
  Future<void> editComment(String postId, String commentId, String updatedComment);
}