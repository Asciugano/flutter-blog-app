import 'package:blog/core/entities/user.dart';
import 'package:blog/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> singUp({
    required String email,
    required String name,
    required String password,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
