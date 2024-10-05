import 'package:dartz/dartz.dart';
import 'package:instagram_clone/features/auth/domain/entities/auth_use_entity.dart';

import '../use_case/sign_up_use_case.dart';

abstract class AuthRepository {
  Future<Either<String, AuthUserEntity>> createUserWithEmailAndPassword({
    required SignUpParams signUpParams,
  });

  Future<Either<String, void>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<String, void>> forgotPassword({
    required String email,
  });

  Future<Either<String, void>> verifyEmail();
}
