import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/domain/usecases/login_use_case.dart';
import 'package:movies/features/auth/presentation/cubit/loginScreen/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState>{
  LoginUseCase loginuseCase;
  LoginCubit(this.loginuseCase): super(LoginInitial());

  Future<void> login(String email , String password)async{
    try {
      emit(LoginLoadingState());
       var result = await loginuseCase.login(email, password);
       result.fold(ifLeft: (errMsg) => emit(LoginErrorState(errorMessage: errMsg.message)), ifRight: (success) => emit(LoginSuccessState(success , success.message)));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}