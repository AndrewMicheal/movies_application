import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failure.dart';
import '../repos/profile_repo.dart';

@injectable
class DeleteAccountUseCase {
  final ProfileRepo repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure, void>> call(String token) async {
    return await repository.deleteAccount(token);
  }
}