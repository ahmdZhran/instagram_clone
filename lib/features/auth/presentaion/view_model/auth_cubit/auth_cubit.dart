import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/functions/image_picker_method.dart';
import '../../../data/repositry/firebase_auth_reposityr.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositry _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> resetPasswordKey = GlobalKey();
  Uint8List? profileImage;
  bool isObsecurePasswordText = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUserWithEmailAndPassword() async {
    emit(CreateUserLoading());
    try {
      await _authRepository.createUserWithEmailAndPassword(
        email: emailAddressController.text,
        password: passwordController.text,
        username: usernameController.text,
        name: nameController.text,
        bio: bioController.text,
        profileImage: profileImage,
      );

      emit(CreateUserSuccess());
      await verifyEmail();
    } catch (e) {
      emit(CreateUserFailer(errMessage: e.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(SignInLoading());
      await _authRepository.signInWithEmailAndPassword(
        email: emailAddressController.text,
        password: passwordController.text,
      );
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> resetPasswordWithEmail() async {
    try {
      emit(ResetPasswordLoading());
      await _authRepository.resetPasswordWithEmail(
          email: emailAddressController.text);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(errMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> selectedImageProfile() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    profileImage = image;
    emit(ProfileImageSelected(profileImage));
  }

  void togglePasswordVisibility() {
    isObsecurePasswordText = !isObsecurePasswordText;
    emit(TogglePasswordVisibilityState());
  }

  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }
}