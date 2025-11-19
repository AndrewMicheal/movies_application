import 'package:movies/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  final String name;
  final int avatarIndex;
  final String? email;

  ProfileModel({
    required this.name,
    required this.avatarIndex,
    this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? json['username'] ?? '',
      avatarIndex: json['avatarIndex'] ?? json['avatar_index'] ?? 0,
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatarIndex': avatarIndex,
      'email': email,
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      name: name,
      avatarIndex: avatarIndex,
      email: email,
      phone: '',
    );
  }
}
