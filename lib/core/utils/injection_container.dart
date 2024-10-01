import 'package:get_it/get_it.dart';

import '../../features/auth/auth_di.dart';

final sl = GetIt.instance;

class InjectionContainer {
  Future<void> init() async {
    AuthDI().init();
  }
}
