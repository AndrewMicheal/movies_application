import '../../data/models/register_response_model.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repo;

  RegisterUseCase(this.repo);

  Future<RegisterResponseModel> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) {
    return repo.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      avatarId: avatarId,
    );
  }
}
