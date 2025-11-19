import 'package:dart_either/dart_either.dart';

import '../../../../core/failure.dart';
import '../entities/login.dart';
import '../repositories/login_repo.dart';

class LoginUseCase {
  final LoginRepo repo;

  LoginUseCase(this.repo);

  Future<Either<Failure, Login>> call({
    required String email,
    required String password,
  }) {
    return repo.login(email: email, password: password);
  }
}