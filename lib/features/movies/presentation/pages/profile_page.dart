import 'package:flutter/material.dart';
import 'package:movies/core/token_storage/token_storage.dart';
import 'package:movies/features/profile/presentation/screens/profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? token;
  Future<void> loadToken() async {
    try {
      final t = await TokenStorage.getToken();
      if (!mounted) return;

      setState(() => token = t);
    } catch (e) {

      if (!mounted) return;
      setState(() => token = null);
    }
  }

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ProfileScreen(token: token!);
  }


}
