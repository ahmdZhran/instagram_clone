import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/auth/auth_di.dart';
import '../../../../core/helper/image_service.dart';
import '../../data/repositories/auth_repository.dart';
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
  GlobalKey<FormState> loginFormKey = GlobalKey();
  GlobalKey<FormState> signUpFormKey = GlobalKey();

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

  Future<void> logIn() async {
    emit(LogInLoading());
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: emailAddressController.text,
        password: passwordController.text,
      );
      emit(LogInSuccess());
    } catch (error) {
      emit(LogInFailure(errMessage: error.toString()));
    }
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
    final isRegister = authDI.isRegistered<AuthCubit>(instanceName: _tag);
    if (!isRegister) {
      authDI.registerSingleton<AuthCubit>(
          AuthCubit(authDI(), authDI<ImagePickerService>()),
          instanceName: _tag);
    }
    return authDI.get<AuthCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = authDI.isRegistered<AuthCubit>(instanceName: _tag);
    if (isRegister) {
      await authDI.unregister<AuthCubit>(instanceName: _tag);
    }
  }
}
