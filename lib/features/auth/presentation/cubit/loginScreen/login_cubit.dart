import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';
import '../../../../../core/token_storage/token_storage.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/usecases/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      final result = await loginUseCase(email: email, password: password);

      await result.fold(
        // Left side - Failure
        ifLeft: (Failure failure) async {
          final errorMessage = failure.message ?? 'Login failed';
          emit(LoginFailureState(message: errorMessage));
        },
        // Right side - Success
        ifRight: (Login login) async {
          if (login.token.isEmpty) {
            emit(LoginFailureState(message: 'No token received from server'));
            return;
          }

          final token = login.token;

          // Try to save token
          try {
            final saved = await TokenStorage.saveToken(token);

            if (!saved) {
              emit(
                LoginErrorState(
                  errorMessage: 'Failed to save authentication token',
                ),
              );
              return;
            }

            // Verify token was saved correctly
            final verifyToken = await TokenStorage.getToken();
            if (verifyToken == null || verifyToken.isEmpty) {
              emit(LoginErrorState(errorMessage: 'Token verification failed'));
              return;
            }

            // Emit success state
            emit(LoginSuccessState(login, 'Login successful'));
          } catch (e) {
            emit(
              LoginErrorState(
                errorMessage: 'Failed to save token: ${e.toString()}',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        LoginErrorState(
          errorMessage: 'An unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await TokenStorage.deleteToken();
      emit(LoginInitial());
    } catch (e) {}
  }
}
