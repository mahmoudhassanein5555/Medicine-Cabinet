import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

enum AuthAction {
  login,
  register,
  googleSignIn,
  forgotPassword,
  logout,
}

class AuthLoading extends AuthState {
  final AuthAction action;

  AuthLoading(this.action);
}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess(this.user);
}

class ForgotPasswordSuccess extends AuthState {}

class AuthError extends AuthState {
  final Failure failure;

  AuthError(this.failure);
}