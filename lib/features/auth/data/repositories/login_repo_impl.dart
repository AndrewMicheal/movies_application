import 'package:dart_either/dart_either.dart';
import '../../../../core/failure.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/login.dart';
import '../../domain/repositories/login_repo.dart';
import '../data_sources/login_remote_data_source.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Login>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      final login = Login(
        token: response.token,
        message: response.message,
      );

      return Right(login);
    } catch (e) {
      return Left(Failure(message: 'Login failed: $e'));
    }
  }
}