import 'package:instagram_clone/features/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<void> createPost(PostEntity post);
  Future<void> deletePost(String postId);
}
