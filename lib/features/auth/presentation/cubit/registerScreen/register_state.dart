import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final String message;
  final Map<String, dynamic>? data;

  const RegisterSuccess(this.message, [this.data]);

  @override
  List<Object?> get props => [message, data];
}

class RegisterFailure extends RegisterState {
  final String message;
  const RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}
