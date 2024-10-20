import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/auth/auth_di.dart';
import '../../../../../core/helper/image_service.dart';
import '../../../../../core/utils/internet_checker.dart';
import '../../../data/repositories/auth_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._pickerImageService)
      : super(AuthInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? profileImage;
  final ImagePickerService _pickerImageService;
  final AuthRepository _authRepository;
  bool obscuredPasswordText = true;



  Future<void> createUserWithEmailAndPassword() async {
    emit(CreateUserLoading());

    final result = await _authRepository.createUserWithEmailAndPassword(
      email: emailAddressController.text.trim(),
      password: passwordController.text.trim(),
      username: usernameController.text.trim(),
      name: nameController.text.trim(),
      bio: bioController.text.trim(),
      profileImage: profileImage,
    );

    result.fold(
      (errorMessage) {
        emit(CreateUserFailure(errMessage: errorMessage));
      },
      (_) async {
        await verifyEmail();
        emit(CreateUserSuccess());
      },
    );
  }

  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  Future<void> logIn() async {
    await InternetChecker.checkInternetConnection();
    emit(LogInLoading());
    final result = await _authRepository.logInWithEmailAndPassword(
      email: emailAddressController.text.trim(),
      password: passwordController.text.trim(),
    );

    result.fold(
      (errorMessage) {
        emit(LogInFailure(errMessage: errorMessage));
      },
      (_) {
        emit(LogInSuccess());
      },
    );
  }

  Future<void> resetPassword() async {
    emit(ResetPasswordLoading());
    final result = await _authRepository.resetPasswordWithEmail(
      email: emailAddressController.text,
    );

    result.fold(
      (errorMessage) {
        emit(ResetPasswordFailure(errMessage: errorMessage));
      },
      (_) {
        emit(ResetPasswordSuccess());
      },
    );
  }

  void obscuredPassword() {
    obscuredPasswordText = !obscuredPasswordText;
    emit(ObscuredPasswordTextState());
  }

  Future<void> selectedImageProfile() async {
    final Uint8List? image =
        await _pickerImageService.pickImage(ImageSource.gallery);
    if (image != null) {
      profileImage = image;
      emit(ProfileImageSelected(image));
    }
  }

  static const String _tag = "auth_instance";
  static AuthCubit getInstance() {
    final isRegister = authDI.isRegistered<AuthCubit>(instanceName: _tag);
    if (!isRegister) {
      authDI.registerSingleton<AuthCubit>(
        AuthCubit(authDI(), authDI<ImagePickerService>()),
        instanceName: _tag,
      );
    }
    return authDI.get<AuthCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = authDI.isRegistered<AuthCubit>(instanceName: _tag);
    if (isRegister) {
      final cubit = authDI<AuthCubit>(instanceName: _tag);
      await cubit.close();
      authDI.unregister<AuthCubit>(instanceName: _tag);
    }
  }
}
