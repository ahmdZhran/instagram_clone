import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/home/domain/repositories/home_Repository.dart';
import 'package:instagram_clone/features/posts/domain/entities/post_entity.dart';

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
  Future<void> toggleLikedPost(String postID, String userID) {
    // TODO: implement toggleLikedPost
    throw UnimplementedError();
  }
    

}
