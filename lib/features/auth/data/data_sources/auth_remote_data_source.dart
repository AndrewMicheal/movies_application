import 'package:dio/dio.dart';
import '../../data/models/register_response_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    final response = await dio.post(
      "https://route-movie-apis.vercel.app/auth/register",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avatarId,
      },
    );

    return RegisterResponseModel.fromJson(
      response.data,
      statusCode: response.statusCode,
    );
  }
}
