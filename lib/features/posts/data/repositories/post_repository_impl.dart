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
}
