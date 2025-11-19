
import 'package:dart_either/dart_either.dart';
import 'package:movies/core/failure.dart';
import 'package:movies/features/auth/domain/entities/login.dart';

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
