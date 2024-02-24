import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String? firstName;
  String? lasttName;
  String? emailAddress;
  String? password;
  bool isObsecurePasswordText = true;
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> resePassowrdKey = GlobalKey();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      emit(CreateUserLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      verfyEmail();
      emit(CreateUserSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
            CreateUserFailer(errMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(CreateUserFailer(
            errMessage: 'The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        emit(CreateUserFailer(errMessage: 'The email is invalid'));
      } else {
        emit(CreateUserFailer(errMessage: e.toString()));
      }
    } catch (e) {
      emit(CreateUserFailer(errMessage: e.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      verfyEmail();
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SigninFailure(errMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SigninFailure(
            errMessage: 'Wrong password provided for that user.'));
      } else {
        emit(SigninFailure(errMessage: 'check your email and password'));
      }
    } catch (e) {
      emit(SigninFailure(errMessage: e.toString()));
    }
  }

  void obsecurePasswordText() {
    isObsecurePasswordText = !isObsecurePasswordText;
    emit(ObsecurePasswordTextState());
  }

  Future<void> verfyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<void> resetPasswordWithEmail() async {
    try {
      emit(EmailResetPasswordLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress!);
      emit(EmailResetPasswordSuccess());
    } catch (e) {
      emit(EmailResetPasswordFailer(errMessage: e.toString()));
    }
  }
}
