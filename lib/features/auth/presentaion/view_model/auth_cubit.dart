import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String? firstName;
  String? lasttName;
  String? emailAdress;
  String? password;
  bool isObsecurePasswordText = true;
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  void obsecurePasswordText() {
    isObsecurePasswordText = !isObsecurePasswordText;
    emit(ObsecurePasswordTextState());
  }
}
