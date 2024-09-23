import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utils/injection_container.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static const String _tag = "auth_instance";
  static AuthCubit getInstance() {
    final isRegister = sl.isRegistered<AuthCubit>(instanceName: _tag);
    if (!isRegister) {
      sl.registerSingleton<AuthCubit>(AuthCubit(), instanceName: _tag);
    }
    return sl.get<AuthCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = sl.isRegistered<AuthCubit>(instanceName: _tag);
    if (!isRegister) {
      await sl.unregister<AuthCubit>(instanceName: _tag);
    }
  }

  bool obscuredPasswordText = true;

  void obscuredPassword() {
    obscuredPasswordText = !obscuredPasswordText;
    emit(ObscuredPasswordTextState());
  }
}
