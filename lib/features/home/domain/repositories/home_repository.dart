import '../../../posts/domain/entities/post_entity.dart';

abstract class HomeRepository {
  Future<Stream<List<PostEntity>>> fetchAllPosts();
  Future<void>toggleLikedPost(String postID, String userID);
}
