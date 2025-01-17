import 'package:flutter/material.dart';

class WaterTrackingScreen extends StatelessWidget {
  const WaterTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracking'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: const Center(
        child: Text(
          'Track your water intake here!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
