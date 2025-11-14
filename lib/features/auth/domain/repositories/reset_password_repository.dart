abstract class ResetPasswordRepository {
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  });
}
