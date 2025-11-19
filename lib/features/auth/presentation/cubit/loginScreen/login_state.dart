import 'package:equatable/equatable.dart';
import 'package:movies/features/auth/domain/entities/login.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginSuccessState extends LoginState {
  final Login login;
  final String message;
  LoginSuccessState(this.login, this.message,);

  @override
  List<Object?> get props => [login, message];
}