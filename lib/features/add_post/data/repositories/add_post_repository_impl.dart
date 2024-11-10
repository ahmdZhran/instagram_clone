import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/add_post_repository.dart';

class AddPostRepositoryImpl implements AddPostRepository {
  
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");
  @override
  Future<void> createPost(PostEntity post) async {
    try {
      await postCollection.doc(post.id).set(post.toJson());
    } catch (error) {
      throw Exception("Error creating post $error");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postCollection.doc(postId).delete();
  }

  @override
  Future<List<PostEntity>> fetchAllPosts() async {
    try {
      final postsSnapShot =
          await postCollection.orderBy('timestamp', descending: true).get();
      final List<PostEntity> allPosts = postsSnapShot.docs
          .map((doc) => PostEntity.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return allPosts;
    } catch (error) {
      throw Exception("Error fetching posts $error");
    }
  }

  @override
  Future<List<PostEntity>> fetchPostsByUserId(String userId) async {
    try {
      final postSnapShot =
          await postCollection.where('userId', isEqualTo: userId).get();
      final userPosts = postSnapShot.docs
          .map((doc) => PostEntity.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return userPosts;
    } catch (error) {
      throw Exception("Error fetching posts by userId $error");
    }
  }
}
