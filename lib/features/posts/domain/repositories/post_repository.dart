import 'package:instagram_clone/features/posts/domain/entities/post_entity.dart';

abstract class AddPostRepository {
 Future<Stream<List<PostEntity>>> fetchAllPosts();
  Future<List<PostEntity>> fetchPostsByUserId(String userId);
  Future<void> createPost(PostEntity post);
  Future<void> deletePost(String postId);
}
