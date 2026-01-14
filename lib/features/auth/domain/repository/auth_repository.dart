import 'package:blog/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // TODO: Update the String to a User from the repository

  Future<Either<Failure, String>> singUp({
    required String email,
    required String name,
    required String password,
  });

  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });
}
