import 'package:dartz/dartz.dart';
import '../../../../core/failure.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileEntity>> getProfile(String token);

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String token,
    required String name,
    required String phone,
    required int avatarIndex,
  });

  Future<Either<Failure, void>> deleteAccount(String token);
}