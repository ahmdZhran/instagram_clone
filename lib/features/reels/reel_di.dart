import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/reels/data/repositories/reels_repository.dart';

final reelDI = GetIt.instance;

class ReelDi {
  Future<void> init() async {
    reelDI.registerLazySingleton(() => ReelsRepository());
  }
}
