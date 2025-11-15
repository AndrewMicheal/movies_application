abstract class ResetPasswordRepository {
  Future<String> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  });
}
