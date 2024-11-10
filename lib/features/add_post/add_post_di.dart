import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/add_post/data/repositories/add_post_repository_impl.dart';
import 'package:instagram_clone/features/add_post/domain/repositories/add_post_repository.dart';

final addPostDi = GetIt.instance;

class AddPostDi {
  Future<void> init() async {
    addPostDi.registerLazySingleton(() => FirebaseFirestore.instance);
    addPostDi.registerLazySingleton<AddPostRepository>(
        () => AddPostRepositoryImpl());
  }


   
}
