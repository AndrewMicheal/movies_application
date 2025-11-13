import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_state.dart';
import '../../data/models/register_response_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(const RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    emit(const RegisterLoading());

    try {
      final RegisterResponseModel result = await registerUseCase(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
        avatarId: avatarId,
      );

      final status = result.statusCode ?? 200;

      if (status >= 200 && status < 300) {
        emit(RegisterSuccess(result.message, result.data));
      } else {
        final msg = result.message.isNotEmpty ? result.message : 'Registration failed';
        emit(RegisterFailure(msg));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
