part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLogged extends AppUserState {
  final User user;

  AppUserLogged({required this.user});
}
