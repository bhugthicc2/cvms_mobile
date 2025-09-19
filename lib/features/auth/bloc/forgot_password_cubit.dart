import 'package:cvms_mobile/features/auth/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _repo;

  ForgotPasswordCubit({AuthRepository? repo})
    : _repo = repo ?? AuthRepository(),
      super(ForgotPasswordInitial());

  Future<void> sendReset(String email) async {
    if (state is ForgotPasswordLoading) return;
    emit(ForgotPasswordLoading());
    try {
      await _repo.sendPasswordResetEmail(email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
