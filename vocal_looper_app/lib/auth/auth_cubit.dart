import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  StreamSubscription<bool>? _sub;

  AuthCubit({required this.authService}) : super(authService.stateFromAuth) {
    _sub = authService.isSignedInStream.listen((isSignedIn) {
      emit(authService.stateFromAuth);
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(SigningState());
    await Future<void>.delayed(const Duration(seconds: 1));

    String? errorMessage = await authService.signInWithEmail(
      email: email,
      password: password,
    );
    if (errorMessage != null) {
      emit(ErrorState(error: errorMessage));
    } else {
      emit(SignedInState(email: email));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(SigningState());
    await Future<void>.delayed(const Duration(seconds: 1));

    String? errorMessage = await authService.signUp(
      email: email,
      password: password,
    );
    if (errorMessage != null) {
      emit(ErrorState(error: errorMessage));
    } else {
      emit(SignedInState(email: email));
    }
  }

  Future<void> signOut() async {
    await authService.signOut();

    emit(SignedOutState());
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}

sealed class AuthState with EquatableMixin {}

class SignedInState extends AuthState {
  SignedInState({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class SigningState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AuthState {
  ErrorState({this.error});

  final String? error;

  @override
  List<Object?> get props => [error];
}

class SignedOutState extends AuthState {
  SignedOutState();

  @override
  List<Object?> get props => [];
}