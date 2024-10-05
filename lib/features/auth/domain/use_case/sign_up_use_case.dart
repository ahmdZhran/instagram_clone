import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:instagram_clone/core/utils/use_case.dart';
import 'package:instagram_clone/features/auth/domain/entities/auth_use_entity.dart';
import 'package:instagram_clone/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase extends UseCase<AuthUserEntity, SignUpParams> {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<Either<String, AuthUserEntity>> call(SignUpParams params) {
    return _authRepository.createUserWithEmailAndPassword(
      signUpParams: params,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String username;
  final String name;
  final String bio;
  final Uint8List? profileImage;

  SignUpParams({
    required this.email,
    required this.password,
    required this.username,
    required this.name,
    required this.bio,
    required this.profileImage,
  });
}
