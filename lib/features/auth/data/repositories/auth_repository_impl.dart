import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remotedataSource;

  AuthRepositoryImpl(this.remotedataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async =>
          await remotedataSource.login(email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> singUp({
    required String email,
    required String name,
    required String password,
  }) async {
    return await _getUser(
      () async => await remotedataSource.signUp(
        email: email,
        name: name,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();

      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
