import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool obscuredPasswordText = true;
  
  void obscuredPassword() {
    obscuredPasswordText = !obscuredPasswordText;
    emit(ObscuredPasswordTextState());
  }
}
