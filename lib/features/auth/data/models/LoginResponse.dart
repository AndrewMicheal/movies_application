import 'package:movies/features/auth/domain/entities/login.dart';

class LoginResponseModel {
  final String message;
  final String data; // This is the token
  final int? statusCode;

  LoginResponseModel({
    required this.message,
    required this.data,
    this.statusCode,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    return LoginResponseModel(
      message: json['message'] ?? '',
      data: json['data'] ?? '', // Token is here
      statusCode: statusCode,
    );
  }

  // Getter for token
  String get token => data;

  // Convert to domain entity
  Login toLogin() {
    return Login(
      token: data, // Pass the token from data field
      message: message,
      data: data,
    );
  }

  @override
  String toString() {
    return 'LoginResponseModel(message: $message, data: $data, statusCode: $statusCode)';
  }
}
