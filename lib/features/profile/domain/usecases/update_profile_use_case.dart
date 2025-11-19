import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failure.dart';
import '../entities/profile_entity.dart';
import '../repos/profile_repo.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepo repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String token,
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    return await repository.updateProfile(
      token: token,
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
    );
  }
}
