import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/explore/data/explore_repository.dart';

final exploreDI = GetIt.instance;

class ExploreDI {
  Future<void> init() async {
    exploreDI
        .registerLazySingleton<ExploreRepository>(() => ExploreRepository());
  }
}
