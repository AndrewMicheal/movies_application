class Login {
  final String? message;
  final String? data;
  final String token; // Make it non-nullable since it's required

  Login({
    this.message,
    this.data,
    required this.token, // Required and will be assigned
  });

  // Add a toString method for debugging
  @override
  String toString() {
    return 'Login(message: $message, data: $data, token: $token)';
  }
}