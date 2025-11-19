import 'package:dio/dio.dart';
import '../../../../core/token_storage/token_storage.dart';
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
    if (avatarId < 1 || avatarId > 3) {
      throw Exception("Invalid avatar selection. Please select an avatar.");
    }
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

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final result = RegisterResponseModel.fromJson(
          response.data as Map<String, dynamic>,
          statusCode: response.statusCode,
        );

        if (result.token != null) {
          await TokenStorage.saveToken(result.token!);
        }

        return result;
      } else {
        // Handle error response
        final result = RegisterResponseModel.fromJson(
          response.data as Map<String, dynamic>,
          statusCode: response.statusCode,
        );
        return result;
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;

        final result = RegisterResponseModel.fromJson(
          data,
          statusCode: e.response!.statusCode,
        );

        if (result.token != null) {
          await TokenStorage.saveToken(result.token!);
        }

        return result;
      }
      throw "Network error";
    } catch (e) {
      throw "Unexpected error";
    }
  }
}
