import 'package:dio/dio.dart';

class ResetPasswordRemoteDataSource {
  final Dio dio;

  ResetPasswordRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.patch(
        "https://route-movie-apis.vercel.app/auth/reset-password",
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return {
        "message": response.data["message"] ?? "Password updated",
        "status": response.statusCode,
      };
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return {
          "message": e.response!.data["message"] ?? "Reset failed",
          "status": e.response!.statusCode,
        };
      }
      throw "Connection error";
    }
  }
}
