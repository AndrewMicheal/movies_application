import 'package:dart_either/dart_either.dart';
import 'package:movies/core/failure.dart';
import 'package:movies/features/auth/domain/entities/login.dart';


abstract class LoginRepo {
  Future<Either<Failure , Login>> login(String email, String password);
}