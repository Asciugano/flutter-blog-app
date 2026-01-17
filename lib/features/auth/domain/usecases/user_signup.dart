import 'package:blog/core/entities/user.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecases/usecase.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<User, UserSignupParams> {
  final AuthRepository authRepository;

  UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.singUp(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String email;
  final String name;
  final String password;

  UserSignupParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
