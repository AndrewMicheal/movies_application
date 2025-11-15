import 'package:dio/dio.dart';

class ResetPasswordRemoteDataSource {
  final Dio dio;

  ResetPasswordRemoteDataSource(this.dio);

  Future<String> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data["message"] ?? "Password updated successfully";
    } else {
      throw response.data["message"] ?? "Failed to update password";
    }
  }
}
