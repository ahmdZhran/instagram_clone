import 'package:get_it/get_it.dart';
import 'data/repositories/post_repository_impl.dart';

final addPostDi = GetIt.instance;

class AddPostDI {
  Future<void> init() async {
    addPostDi.registerLazySingleton(() => PostRepositoryImpl());
  }
}
