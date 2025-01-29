import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/home/data/models/comment_model.dart';
import '../../../posts/data/models/post_model.dart';
import '../../domain/repositories/home_Repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

  final CollectionReference commentCollection =
      FirebaseFirestore.instance.collection("comments");

  @override
  Future<Stream<List<PostModel>>> fetchAllPosts() async {
    try {
      return postCollection
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map(
                (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
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
        final post = PostModel.fromJson(postDoc.data() as Map<String, dynamic>);
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
  Future<void> addComment(String postId, CommentModel commentEntity) async {
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
  Future<Stream<List<CommentModel>>> fetchComments(String postId) async {
    try {
      return FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .orderBy("dateOfComment")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return CommentModel.fromJson(doc.data());
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
        'commentText': updatedComment,
      });
    } catch (error) {
      throw Exception("Error editing comment: $error");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await postCollection.doc(postId).delete();
      final commentsSnapshot =
          await postCollection.doc(postId).collection("comments").get();
      for (var doc in commentsSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (error) {
      throw Exception("Error deleting post: $error");
    }
  }
  
}
