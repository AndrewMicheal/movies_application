import '../../data/models/register_response_model.dart';

abstract class AuthRepository {
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  });
}
