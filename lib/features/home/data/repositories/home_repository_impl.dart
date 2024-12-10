import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/home_Repository.dart';
import '../../../posts/domain/entities/post_entity.dart';

import '../../domain/entities/comment_entity/comment_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

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
  Future<void> toggleLikedPost(String postID, String userID) async {
    try {
      final postDoc = await postCollection.doc(postID).get();
      if (postDoc.exists) {
        final post =
            PostEntity.fromJson(postDoc.data() as Map<String, dynamic>);
        final hasLiked = post.likes.contains(userID);
        if (hasLiked) {
          post.likes.remove(userID);
        } else {
          post.likes.add(userID);
        }
        await postCollection.doc(postID).update({
          'likes': post.likes,
        });
      } else {
        throw Exception("Post not found");
      }
    } catch (error) {
      throw Exception("Error toggling like: $error");
    }
  }

  @override
  Future<void> addComment(String postId, CommentEntity commentEntity) async {
    try {
      await postCollection
          .doc(postId)
          .collection("comments")
          .doc(commentEntity.commentId)
          .set(commentEntity.toMap());
    } catch (error) {
      throw Exception("Error adding comment: $error");
    }
  }
}
