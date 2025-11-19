import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/profile/domain/entities/profile_entity.dart';
import '../../../../core/failure.dart';
import '../../domain/repos/profile_repo.dart';
import '../datasources/profile_remote_ds.dart';

@Injectable(as: ProfileRepo)
class ProfileRepositoryImpl implements ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String token) async {
    try {
      final profile = await remoteDataSource.getProfile(token);
      return Right(profile);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String token,
    required String name,
    required int avatarIndex,
    required String phone,
  }) async {
    try {
      final profile = await remoteDataSource.updateProfile(
        token: token,
        name: name,
        avatarIndex: avatarIndex,
      );
      return Right(profile);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String token) {
    throw UnimplementedError();
  }
}
