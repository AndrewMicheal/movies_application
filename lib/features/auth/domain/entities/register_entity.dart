class RegisterEntity {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avatarId;

  RegisterEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avatarId,
  });
}
