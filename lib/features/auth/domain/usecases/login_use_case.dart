import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/failure.dart';
import 'package:movies/features/auth/domain/entities/login.dart';
import 'package:movies/features/auth/domain/repositories/login_repo.dart';

@injectable
class LoginUseCase {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);

  Future<Either<Failure, Login>> login(String email,  String password,) async {
    
    return await loginRepo.login(email, password);
  }
}