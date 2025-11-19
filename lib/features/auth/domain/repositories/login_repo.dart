import 'package:dart_either/dart_either.dart';

import '../../../../core/failure.dart';
import '../entities/login.dart';

abstract class LoginRepo {
  Future<Either<Failure, Login>> login({
    required String email,
    required String password,
  });
}