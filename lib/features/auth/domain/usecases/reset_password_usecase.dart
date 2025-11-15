import 'package:movies/features/auth/domain/repositories/reset_password_repository.dart';

class ResetPasswordUseCase {
  final ResetPasswordRepository repo;

  ResetPasswordUseCase(this.repo);

  Future<String> call({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) {
    return repo.resetPassword(
      token: token,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
