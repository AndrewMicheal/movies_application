import '../../domain/entities/register_entity.dart';

class RegisterRequestModel extends RegisterEntity {
  RegisterRequestModel({
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
    required super.phone,
    required super.avatarId,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "phone": phone,
    "avaterId": avatarId,
  };
}
