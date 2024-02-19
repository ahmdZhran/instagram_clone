import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> createUserWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      emit(CreateUserLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(CreateUserSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
            CreateUserFailer(errMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(CreateUserFailer(
            errMessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(CreateUserFailer(errMessage: e.toString()));
    }
  }

  void obsecurePasswordText() {
    isObsecurePasswordText = !isObsecurePasswordText;
    emit(ObsecurePasswordTextState());
  }
}
