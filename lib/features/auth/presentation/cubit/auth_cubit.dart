import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/utils/shared_prefs_local_data_source.dart';
import '../../domain/usecases/forgot_password_use_case.dart';
import '../../domain/usecases/google_sign_in_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GoogleSigninUseCase googleSignInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final CacheHelper cacheHelper;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.googleSignInUseCase,
    required this.forgotPasswordUseCase,
    required this.logoutUseCase,
    required this.cacheHelper,
  }) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading(AuthAction.login));

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );
      await cacheHelper.saveData(key: AppKeys.userId, value: user.id);
      emit(AuthSuccess(user));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading(AuthAction.register));

    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading(AuthAction.googleSignIn));
    try {
      final user = await googleSignInUseCase();
      await cacheHelper.saveData(
        key: AppKeys.userId,
        value: user.id,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure));
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(AuthLoading(AuthAction.forgotPassword));
    try {
      await forgotPasswordUseCase(
        email: email,
      );
      emit(ForgotPasswordSuccess());
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading(AuthAction.logout));
    try {
      await logoutUseCase();
      await cacheHelper.removeData(key: AppKeys.userId);
      emit(AuthInitial());
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure));
    }
  }
}
