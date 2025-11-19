import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/profile/domain/entities/profile_entity.dart';
import '../../../../core/failure.dart';
import '../repos/profile_repo.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepo repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(String token) async {
    return await repository.getProfile(token);
  }
}
