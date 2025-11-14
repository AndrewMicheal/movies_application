import 'package:dart_either/src/dart_either.dart';

import 'package:movies/core/failure.dart';

import 'package:movies/features/auth/domain/entities/login.dart';

import '../../data/models/register_response_model.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    try {
      return await remote.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
        avatarId: avatarId,
      );
    } catch (e) {
      return RegisterResponseModel(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
