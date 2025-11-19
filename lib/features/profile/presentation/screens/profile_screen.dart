import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/token_storage/token_storage.dart';
import '../../../../core/assets_manager.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required String token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> avatars = [
    AssetsManager.avatarImage1,
    AssetsManager.avatarImage2,
    AssetsManager.avatarImage3,
  ];

  String? _token;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      print('🔍 Attempting to load profile...');
      final token = await TokenStorage.getToken();

      print('🔍 Token retrieved: ${token ?? "NULL"}');

      if (token == null || token.isEmpty) {
        print('❌ Token is missing or empty');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Session expired. Please login again.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          // Navigate back to login
          Navigator.of(context).pushReplacementNamed('/login');
        }
        return;
      }

      setState(() {
        _token = token;
      });

      print('✅ Token set, fetching profile...');

      if (mounted) {
        context.read<ProfileCubit>().getProfile(token);
      }
    } catch (e) {
      print('❌ Error loading profile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load profile: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ProfileActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final p = state.profile;

              // Check if token is available
              if (_token == null) {
                return const Center(
                  child: Text(
                    'Session expired. Please login again.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 30),

                  // Profile Avatar
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                      avatars[p.avatarIndex.clamp(0, avatars.length - 1)],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // User Name
                  Text(
                    p.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Stats Row (Wish List & History)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('12', 'Wish List'),
                        _buildStatItem('10', 'History'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_token == null) return;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ProfileCubit>(),
                                    child: EditProfileScreen(token: _token!),
                                  ),
                                ),
                              ).then((_) {
                                // Refresh profile data when coming back
                                if (_token != null) {
                                  context.read<ProfileCubit>().getProfile(_token!);
                                }
                              });
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: const [
                              Text(
                                'Exit',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.exit_to_app, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Secondary Buttons Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildSecondaryButton(
                            icon: Icons.bookmark_border,
                            label: 'Watch List',
                            onPressed: () {
                              // Navigate to Watch List
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSecondaryButton(
                            icon: Icons.folder_outlined,
                            label: 'History',
                            onPressed: () {
                              // Navigate to History
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Large Icon in Center
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/popcorn.png',
                        width: 120,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.local_movies,
                            color: Color(0xFFFFC107),
                            size: 120,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFFFC107),
        side: const BorderSide(color: Color(0xFFFFC107), width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}