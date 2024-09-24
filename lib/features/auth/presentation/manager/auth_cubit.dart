import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/utils/injection_container.dart';
import 'package:instagram_clone/features/auth/auth_di.dart';

import '../../../../core/helper/image_picker_service.dart';
import '../../data/repositories/auth_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._imagePickerService)
      : super(AuthInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? profileImage;

  final AuthRepository _authRepository;
  final ImagePickerService _imagePickerService;
  GlobalKey<FormState> loginFormKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();

  bool obscuredPasswordText = true;

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
    } catch (e) {
      emit(CreateUserFailure(errMessage: e.toString()));
    }
  }

Future<void> selectedImageProfile() async {
  Uint8List? image = await _imagePickerService.pickImage(ImageSource.gallery);
  if (image != null) {
    profileImage = image;
    emit(ProfileImageSelected(profileImage!));  // Emit only when a valid image is selected
  }
}

  void obscuredPassword() {
    obscuredPasswordText = !obscuredPasswordText;
    emit(ObscuredPasswordTextState());
  }

  //TODO check user auth state
//  Future<void> checkAuthStatus() async {
//       final user = await _authRepository.getCurrentUser();
//       if (user != null) {
//         emit(AuthSuccess(user));
//       } else {
//         emit(AuthLoggedOut());
//       }
//     }
  static const String _tag = "auth_instance";
  static AuthCubit getInstance() {
    final isRegister = sl.isRegistered<AuthCubit>(instanceName: _tag);
    if (!isRegister) {
      sl.registerSingleton<AuthCubit>(
          AuthCubit(authDI(), sl<ImagePickerService>()),
          instanceName: _tag);
    }
    return sl.get<AuthCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = sl.isRegistered<AuthCubit>(instanceName: _tag);
    if (isRegister) {
      await sl.unregister<AuthCubit>(instanceName: _tag);
    }
  }
}
