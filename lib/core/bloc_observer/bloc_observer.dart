import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  void _log(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: 'BlocObserver',
        error: error,
        stackTrace: stackTrace,
      );
      debugPrint('[BlocObserver] $message');
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log('🟢 [CREATE] ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _log('⚡ [EVENT] ${bloc.runtimeType} -> $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log(
      '🔄 [CHANGE] ${bloc.runtimeType}\n'
      '   ├─ Current: ${change.currentState}\n'
      '   └─ Next:    ${change.nextState}',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log(
      '🔀 [TRANSITION] ${bloc.runtimeType}\n'
      '   ├─ Event:   ${transition.event}\n'
      '   ├─ Current: ${transition.currentState}\n'
      '   └─ Next:    ${transition.nextState}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log(
      '🔴 [ERROR] ${bloc.runtimeType} -> $error',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _log('⚪ [CLOSE] ${bloc.runtimeType}');
  }
}
