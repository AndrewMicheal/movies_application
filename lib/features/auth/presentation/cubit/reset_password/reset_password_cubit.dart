import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/auth/presentation/cubit/reset_password/reset_passowrd_state.dart';
import '../../../domain/usecases/reset_password_usecase.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit(this.resetPasswordUseCase)
      : super(const ResetPasswordInitial());

  Future<void> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(const ResetPasswordLoading());

    final result = await resetPasswordUseCase(
      token: token,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    final status = result["status"] ?? 400;

    if (status >= 200 && status < 300) {
      emit(ResetPasswordSuccess(result["message"]));
    } else {
      String msg = result["message"] ?? "Failed";
      emit(ResetPasswordFailure(msg));
    }
  }
}
