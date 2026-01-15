import 'package:blog/core/error/failures.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // TODO: Update the String to a User from the repository

  Future<Either<Failure, User>> singUp({
    required String email,
    required String name,
    required String password,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
