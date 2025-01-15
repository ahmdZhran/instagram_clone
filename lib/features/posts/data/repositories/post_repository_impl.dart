import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/posts/data/models/post_model.dart';

class PostRepositoryImpl {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

  Future<void> createPost(PostModel post) async {
    try {
      await postCollection.doc(post.id).set(post.toJson());
    } catch (error) {
      throw Exception("Error creating post $error");
    }
  }

  Future<void> deletePost(String postId) async {
    await postCollection.doc(postId).delete();
  }
}
