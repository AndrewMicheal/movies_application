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
      print('🌐 API Request: GET /profile');
      print('🔑 Token: $token');

      final response = await dio.get(
        '/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('✅ Response Status: ${response.statusCode}');
      print('📦 Response Data: ${response.data}');

      // Handle different response structures
      final data = response.data['data'] ?? response.data;
      return ProfileModel.fromJson(data).toEntity();

    } on DioException catch (e) {
      print('❌ Profile API Error:');
      print('   Status: ${e.response?.statusCode}');
      print('   Message: ${e.message}');
      print('   Data: ${e.response?.data}');

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
      print('🌐 API Request: PUT /profile');
      print('🔑 Token: $token');
      print('📤 Data: name=$name, avatarIndex=$avatarIndex');

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

      print('✅ Update successful: ${response.statusCode}');

      final data = response.data['data'] ?? response.data;
      return ProfileModel.fromJson(data).toEntity();

    } on DioException catch (e) {
      print('❌ Update Profile Error: ${e.message}');
      throw Exception(e.response?.data['message'] ?? 'Failed to update profile');
    }
  }
}
