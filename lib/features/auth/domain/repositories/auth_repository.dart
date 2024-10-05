import 'package:dartz/dartz.dart';
import 'package:instagram_clone/features/auth/domain/entities/auth_use_entity.dart';

import '../use_case/sign_up_use_case.dart';

abstract class AuthRepository {
  Future<Either<String, AuthUserEntity>> createUserWithEmailAndPassword({
    required SignUpParams signUpParams,
  });
}
