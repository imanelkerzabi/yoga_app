import 'package:flutter/material.dart';
import 'package:yoga_app/screens/YogaDetailsPage.dart';
import 'package:yoga_app/screens/WaterTrackingScreen.dart';
import 'package:yoga_app/screens/SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const YogaDetailsPage(),
    const WaterTrackingScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline), label: 'Sessions'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Water'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
