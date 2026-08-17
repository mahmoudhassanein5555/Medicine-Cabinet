import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/utils/shared_prefs_local_data_source.dart';
import '../../domain/usecases/ForgotPasswordUseCase.dart';
import '../../domain/usecases/GoogleSignInUseCase.dart';
import '../../domain/usecases/LoginUseCase.dart';
import '../../domain/usecases/LogoutUseCase.dart';
import '../../domain/usecases/RegisterUseCase.dart';
import 'auth_state.dart';
import 'package:injectable/injectable.dart';

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

  Future<void> login({required String email, required String password,}) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );
      await cacheHelper.saveData(key: AppKeys.userId, value: user.id);
      emit(AuthSuccess(user));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure.failuremessage));
    }
  }

  Future<void> register({required String name, required String email, required String password,}) async {
    emit(AuthLoading());

    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
      );
      await cacheHelper.saveData(
        key: AppKeys.userId,
        value: user.id,
      );
      emit(AuthSuccess(user));
    }  catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure.failuremessage));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      final user = await googleSignInUseCase();
      await cacheHelper.saveData(
        key: AppKeys.userId,
        value: user.id,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure.failuremessage));
    }
  }
  Future<void> forgotPassword({required String email,}) async {
    emit(AuthLoading());
    try {
      await forgotPasswordUseCase(
        email: email,
      );
      emit(ForgotPasswordSuccess());
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure.failuremessage));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await logoutUseCase();
      await cacheHelper.removeData(key: AppKeys.userId);
      emit(AuthInitial());
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(AuthError(failure.failuremessage));
    }
  }
}
