import 'package:cvms_mobile/features/auth/bloc/auth_state.dart';
import 'package:cvms_mobile/features/auth/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(
    String email,
    String password, {
    bool keepMeLoggedIn = false,
  }) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(
        email,
        password,
        keepLoggedIn: keepMeLoggedIn,
      );
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("User not found"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Authentication failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkKeepLoggedIn() async {
    emit(AuthLoading());
    try {
      final user = await authRepository.getLoggedInUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthLoggedOut());
      }
    } catch (e) {
      emit(AuthLoggedOut());
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(AuthLoggedOut());
  }
}
