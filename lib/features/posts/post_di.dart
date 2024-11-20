import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/posts/data/repositories/post_repository_impl.dart';
import 'package:instagram_clone/features/posts/domain/repositories/post_repository.dart';

final addPostDi = GetIt.instance;

class AddPostDI {
  Future<void> init() async {
    addPostDi.registerLazySingleton<AddPostRepository>(
      () => AddPostRepositoryImpl(),
    );
  }
}
