import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/profile/domain/entities/profile_entity.dart';
import '../model/profile_model.dart';

@injectable
class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<ProfileEntity> getProfile(String token) async {
    try {


      final response = await dio.get(
        '/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );



      final data = response.data['data'] ?? response.data;
      return ProfileModel.fromJson(data).toEntity();

    } on DioException catch (e) {


      if (e.response?.statusCode == 401) {
        throw Exception('Token is invalid or expired. Please login again.');
      }

      throw Exception(e.response?.data['message'] ?? 'Failed to get profile');
    }
  }

  Future<ProfileEntity> updateProfile({
    required String token,
    required String name,
    required int avatarIndex,
  }) async {
    try {


      final response = await dio.put(
        '/profile',
        data: {
          'name': name,
          'avatarIndex': avatarIndex,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );



      final data = response.data['data'] ?? response.data;
      return ProfileModel.fromJson(data).toEntity();

    } on DioException catch (e) {

      throw Exception(e.response?.data['message'] ?? 'Failed to update profile');
    }
  }
}
