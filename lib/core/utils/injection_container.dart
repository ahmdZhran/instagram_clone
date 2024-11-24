import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/explore/explore_di.dart';
import 'package:instagram_clone/features/posts/post_di.dart';
import '../../features/profile/profile_di.dart';

import '../../features/auth/auth_di.dart';

final sl = GetIt.instance;

class InjectionContainer {
  Future<void> init() async {
    AuthDI().init();
    ProfileDI().init();
    AddPostDI().init();
    ExploreDI().init();
  }
}
