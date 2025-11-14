
import '../../domain/repositories/reset_password_repository.dart';
import '../data_sources/reset_password_remote_data_source.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remote;

  ResetPasswordRepositoryImpl(this.remote);

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) {
    return remote.resetPassword(
      token: token,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
