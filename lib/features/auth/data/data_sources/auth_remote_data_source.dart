import 'package:dio/dio.dart';
import '../models/register_response_model.dart';

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
    try {
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
        response.data as Map<String, dynamic>,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        return RegisterResponseModel.fromJson(
          data,
          statusCode: e.response!.statusCode,
        );
      }
      // fallback
      throw "Network error";
    } catch (e) {
      throw "Unexpected error";
    }
  }
}
