import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/models/user_model.dart';
import '../../../data/repositry/auth_repositry.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());

  String? username;
  String? name;
  String? emailAddress;
  String? password;
  String? bio;
  String? uid;
  bool isObsecurePasswordText = true;
  Uint8List? profileImage;
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> resetPasswordKey = GlobalKey();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> createUserWithEmailAndPassword(Uint8List profileImage) async {
    emit(CreateUserLoading());
    try {
      UserModel userModel = UserModel(
        name: name!,
        username: username!,
        email: emailAddress!,
        password: password!,
        bio: bio!,
        uid: uid!,
      );

      await _authRepository.signUpWithEmailAndPassword(userModel, profileImage);

      emit(CreateUserSuccess());
      await verifyEmail();
    } catch (e) {
      emit(CreateUserFailer(errMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(SignInLoading());
      await _authRepository.signInWithEmailAndPassword(
          emailAddress!, password!);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: 'An unexpected error occurred'));
    }
  }

  void togglePasswordVisibility() {
    isObsecurePasswordText = !isObsecurePasswordText;
    emit(TogglePasswordVisibilityState());
  }

  Future<void> verifyEmail() async {
    try {
      await _authRepository.verifyEmail();
    } catch (e) {
      emit(VerifyEmailFailure(
          errMessage: 'An unexpected error occurred while verifying email'));
    }
  }

  Future<void> resetPasswordWithEmail() async {
    try {
      emit(ResetPasswordLoading());
      await _authRepository.resetPasswordWithEmail(emailAddress!);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(errMessage: 'An unexpected error occurred'));
    }
  }
}
