import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/ForgotPasswordUseCase.dart';
import '../../domain/usecases/GoogleSignInUseCase.dart';
import '../../domain/usecases/LoginUseCase.dart';
import '../../domain/usecases/LogoutUseCase.dart';
import '../../domain/usecases/RegisterUseCase.dart';
import 'Auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GoogleSigninUseCase googleSignInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.googleSignInUseCase,
    required this.forgotPasswordUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      final user = await googleSignInUseCase();

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(AuthLoading());

    try {
      await forgotPasswordUseCase(email: email);

      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await logoutUseCase();

      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
