import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/home_Repository.dart';
import '../../../posts/domain/entities/post_entity.dart';

import '../../domain/entities/comment_entity/comment_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

  final CollectionReference commentCollection =
      FirebaseFirestore.instance.collection("comments");

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
          .set(commentEntity.toJson());
    } catch (error) {
      throw Exception("Error adding comment: $error");
    }
  }

  @override
  Future<Stream<List<CommentEntity>>> fetchComments(String postId) async {
    try {
      return FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .orderBy("dateOfComment")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return CommentEntity.fromJson(doc.data());
        }).toList();
      });
    } catch (error) {
      throw Exception("Error fetching comments: $error");
    }
  }

  @override
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .delete();
    } catch (error) {
      throw Exception("Error deleting comment: $error");
    }
  }

  @override
  Future<void> editComment(
      String postId, String commentId, String updatedComment) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({
        'comment': updatedComment,
      });
    } catch (error) {
      throw Exception("Error editing comment: $error");
    }
  }
}