import 'package:flutter/material.dart';
import 'package:movies/features/movies/presentation/pages/profile_page.dart';
import 'package:movies/features/movies/presentation/pages/search_page.dart';

import 'browse_page.dart';
import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    SearchPage(),
    BrowsePage(),
    ProfilePage(),
  ];

  final List<IconData> _icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.explore_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = index);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.yellow[700]!.withOpacity(0.1)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _icons[index],
                  color: isSelected ? Colors.yellow[700] : Colors.white,
                  size: 28,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
