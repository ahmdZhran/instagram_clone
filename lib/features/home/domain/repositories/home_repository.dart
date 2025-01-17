import 'package:instagram_clone/features/home/data/models/comment_model.dart';
import 'package:instagram_clone/features/posts/data/models/post_model.dart';

abstract class HomeRepository {
  Future<Stream<List<PostModel>>> fetchAllPosts();
  Future<void> toggleLikedPost(String postID, String userID);
  Future<void> addComment(String postId, CommentModel commentEntity);
  Future<Stream<List<CommentModel>>> fetchComments(String postId);
  Future<void> deleteComment(String postId, String commentId);
  Future<void> editComment(String postId, String commentId, String updatedComment);
  Future<void> deletePost(String postId);
}