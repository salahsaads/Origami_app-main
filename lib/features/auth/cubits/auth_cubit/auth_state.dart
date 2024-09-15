part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  bool isLoading;

  AuthLoading(this.isLoading);
}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String title;
  final String message;

  AuthError(this.title, this.message);
}

class AuthPhoneError extends AuthError {
  AuthPhoneError(super.title, super.message);
}
