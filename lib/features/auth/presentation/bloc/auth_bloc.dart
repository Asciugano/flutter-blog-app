import 'package:blog/core/usecases/usecase.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/user_login.dart';
import 'package:blog/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
    required CurrentUser currentUser,
  }) : _userSignup = userSignup,
       _userLogin = userLogin,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSingUp);
    on<AuthLogin>(_onAuthLoginin);
    on<AuthIsUserLogged>(_onIsUserLogged);
  }

  void _onAuthLoginin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin.call(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }

  void _onAuthSingUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignup.call(
      UserSignupParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );

    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }

  void _onIsUserLogged(AuthIsUserLogged event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => emit(AuthFailure(l.message)), (r) => AuthSuccess(r));
  }
}
