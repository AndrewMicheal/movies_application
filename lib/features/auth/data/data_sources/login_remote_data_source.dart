import 'package:movies/features/auth/data/models/LoginResponse.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(String email , String password);
}