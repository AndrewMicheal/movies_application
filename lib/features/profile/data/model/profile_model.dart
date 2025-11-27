import 'package:movies/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  final String name;
  final int avaterId;
  final String? email;
  final String phone;

  ProfileModel({
    required this.name,
    required this.avaterId,
    this.email,
    required this.phone

  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? json['username'] ?? '',
      avaterId: json['avaterId'] ?? json['avatar_index'] ?? 0,
      email: json['email'],
      phone: json['phone'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avaterId': avaterId,
      'email': email,
      'phone' : phone
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      name: name,
      avaterId: avaterId,
      email: email,
      phone: phone,
    );
  }
}
