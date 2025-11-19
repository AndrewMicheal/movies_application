class ProfileEntity {
  final String name;
  final String phone;
  final int avatarIndex;
  final String? email;

  ProfileEntity({
    required this.name,
    required this.phone,
    required this.avatarIndex,
    this.email,
  });

  @override
  String toString() {
    return 'ProfileEntity(name: $name, phone: $phone, avatarIndex: $avatarIndex)';
  }
}