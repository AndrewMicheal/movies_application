class ProfileEntity {
  final String name;
  final String phone;
  final int avaterId;
  final String? email;

  ProfileEntity({
    required this.name,
    required this.phone,
    required this.avaterId,
    this.email,
  });

  @override
  String toString() {
    return 'ProfileEntity(name: $name, phone: $phone, avaterId: $avaterId)';
  }
}