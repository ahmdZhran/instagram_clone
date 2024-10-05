import 'package:dartz/dartz.dart';
import 'package:instagram_clone/core/utils/use_case.dart';
import 'package:instagram_clone/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<void, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);
  @override
  Future<Either<String, void>> call(params) {
    return _authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
