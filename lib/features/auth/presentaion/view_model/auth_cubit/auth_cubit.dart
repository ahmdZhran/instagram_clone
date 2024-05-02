import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/models/user_model.dart';
import 'package:instagram_clone/core/services/firebase_services/storage.dart';

import '../../../../../core/functions/image_picker_method.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
  Future<void> createUserWithEmailAndPassword() async {
    emit(CreateUserLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      String imageUrl = await StorageMethod()
          .uploadImageToStorage('profileImage', profileImage!, false);

      UserModel userModel = UserModel(
        name: name!,
        username: username!,
        email: emailAddress!,
        password: password!,
        bio: bio!,
        imageUrl: imageUrl,
        uid: userCredential.user!.uid,
        follower: [],
        following: [],
      );

      await firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());
      emit(CreateUserSuccess());
      await verifyEmail();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email is invalid';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred';
      }
      emit(CreateUserFailer(errMessage: errorMessage));
    } catch (e) {
      emit(CreateUserFailer(errMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(SignInLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        default:
          errorMessage = 'An error occurred during sign in.';
      }
      emit(SignInFailure(errMessage: errorMessage));
    } catch (e) {
      emit(SignInFailure(errMessage: 'An unexpected error occurred'));
    }
  }

  void togglePasswordVisibility() {
    isObsecurePasswordText = !isObsecurePasswordText;
    emit(TogglePasswordVisibilityState());
  }

  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<void> resetPasswordWithEmail() async {
    try {
      emit(ResetPasswordLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress!);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email.';
      } else {
        errorMessage = 'An error occurred while resetting password.';
      }
      emit(ResetPasswordFailure(errMessage: errorMessage));
    }
  }

  Future<void> selectedImageProfile() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    profileImage = image;
    emit(ProfileImageSelected(profileImage));
  }
}
