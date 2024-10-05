import 'package:dartz/dartz.dart';
import 'package:instagram_clone/core/utils/use_case.dart';
import 'package:instagram_clone/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase extends UseCase<void, String> {
  final AuthRepository _authRepository;

  ForgotPasswordUseCase(this._authRepository);
  @override
  Future<Either<String, void>> call(String params)async {
    return await _authRepository.forgotPassword(email: params);
  }
}
