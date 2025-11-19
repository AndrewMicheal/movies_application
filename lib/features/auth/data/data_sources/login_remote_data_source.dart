import 'package:movies/features/auth/data/models/LoginResponse.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
}