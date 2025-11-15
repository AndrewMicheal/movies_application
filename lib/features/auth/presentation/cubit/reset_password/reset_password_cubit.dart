import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:movies/features/auth/presentation/cubit/reset_password/reset_passowrd_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit(this.resetPasswordUseCase) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        emit(ResetPasswordFailure("You must login first"));
        return;
      }

      final msg = await resetPasswordUseCase(
        token: token,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      emit(ResetPasswordSuccess(msg));
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
