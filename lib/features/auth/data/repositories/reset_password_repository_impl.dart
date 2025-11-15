import 'package:movies/features/auth/data/data_sources/reset_password_remote_data_source.dart';
import 'package:movies/features/auth/domain/repositories/reset_password_repository.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remote;

  ResetPasswordRepositoryImpl(this.remote);

  @override
  Future<String> resetPassword({
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
