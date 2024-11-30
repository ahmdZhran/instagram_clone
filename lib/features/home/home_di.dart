import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/home/data/repositories/home_repository_impl.dart';
import 'package:instagram_clone/features/home/domain/repositories/home_Repository.dart';

final homeDI = GetIt.instance;

class HomeDI {
  Future<void> init() async {
    homeDI.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  }
}
