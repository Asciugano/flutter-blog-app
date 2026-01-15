import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remotedataSource;

  AuthRepositoryImpl(this.remotedataSource);

  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> singUp({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final userID = await remotedataSource.signUp(
        email: email,
        name: name,
        password: password,
      );

      return right(userID);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
