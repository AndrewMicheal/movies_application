import 'package:equatable/equatable.dart';
import 'package:movies/features/auth/domain/entities/login.dart';

abstract class LoginState extends Equatable{
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
}

class LoginLoadingState extends LoginState{

}

class LoginErrorState extends LoginState{
  String errorMessage;
  LoginErrorState({required this.errorMessage});
  List<Object?> get props => [errorMessage];

}

class LoginSuccessState extends LoginState{
  final Login login;
  String? message;
  LoginSuccessState(this.login , message);
  List<Object?> get props => [login , message];

}