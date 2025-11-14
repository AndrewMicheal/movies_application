import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/failure.dart';
import 'package:movies/features/auth/data/data_sources/login_remote_data_source.dart';
import 'package:movies/features/auth/domain/entities/login.dart';
import 'package:movies/features/auth/domain/repositories/login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {

  final LoginRemoteDataSource remote ;

  LoginRepoImpl(this.remote);

  @override
  Future<Either<Failure, Login>> login(String email, String password) async{
    try{
      final result =  await remote.login(email, password);
      return Right(result.toLogin());
    }catch(e){
      return Left(Failure(message: e.toString()));
    }
  }
}