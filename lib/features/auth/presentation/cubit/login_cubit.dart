import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/domain/usecases/login_use_case.dart';
import 'package:movies/features/auth/presentation/cubit/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LoginCubit extends Cubit<LoginState>{
  LoginUseCase loginuseCase;

  LoginCubit(this.loginuseCase): super(LoginInitial());

  Future<void> login(String email, String password) async {
  emit(LoginLoadingState());
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    var result = await loginuseCase.login(email, password);
    
    result.fold(
      ifLeft: (errMsg) => emit(LoginErrorState(errorMessage: errMsg.message)),
      ifRight: (success) async {
        print("TOKEN: ${success.data}");
        await prefs.setString('token', success.data ?? "");
        emit(LoginSuccessState(success, success.message));
      },
    );
  } catch (e) {
    emit(LoginErrorState(errorMessage: e.toString()));
  }
}
}