import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static const String _tag = "Cart_instance";
  static AuthCubit getInstance(){
    final isRegister = getIt.isRegistered<AuthCubit>(instanceName: _tag);
    if(!isRegister){
      getIt.registerSingleton<AuthCubit>(AuthCubit(),instanceName:_tag);
      
    }
     return getIt.get<AuthCubit>(instanceName: _tag);
  }
  static Future<void> deleteInstance() async {
    final isRegister = getIt.isRegistered<AuthCubit>(instanceName: _tag);
    if (!isRegister) {
      await getIt.unregister<AuthCubit>(instanceName: _tag);
    }
  }


  bool obscuredPasswordText = true;

  void obscuredPassword() {
    obscuredPasswordText = !obscuredPasswordText;
    emit(ObscuredPasswordTextState());
  }
}
