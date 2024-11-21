import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
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
  Future<Stream<List<PostEntity>>> fetchAllPosts() async {
    try {
      return postCollection
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) =>
                PostEntity.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      throw Exception("Error fetching posts: $error");
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
