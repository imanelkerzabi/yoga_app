import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:yoga_app/screens/WaterTrackingScreen.dart';
import 'package:yoga_app/screens/practice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  int waterGlasses = 0; // Nombre de verres d'eau consommés
  final int glassSize = 250; // Taille d'un verre d'eau en ml
  final int dailyGoal = 2000; // Objectif journalier en ml (2 litres)

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          userData = null;
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des données utilisateur : $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _updateWaterGlasses(int newGlasses) {
    setState(() {
      waterGlasses = newGlasses;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (userData == null) {
      return const Scaffold(
        body: Center(child: Text('No user data found.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec message de bienvenue
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black87),
                  Text(
                    'Welcome back, ${userData!['name']}!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Section "Your Daily Rate"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Daily Rate',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCircularIndicator(
                        percent: 0.6,
                        valueText: '60%',
                        description: '2 Hours / Day',
                        progressColor: Colors.purple,
                      ),
                      _buildCircularIndicator(
                        percent: (waterGlasses * glassSize) / dailyGoal,
                        valueText:
                            '${((waterGlasses * glassSize) / dailyGoal * 100).toStringAsFixed(0)}%',
                        description:
                            '${(waterGlasses * glassSize / 1000).toStringAsFixed(2)}L / ${(dailyGoal / 1000).toStringAsFixed(2)}L',
                        progressColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section Niveau et Complété
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildModernStatTile(
                    title: 'Level',
                    value: userData!['level'], // Utilise les données d'origine
                    color: Colors.blue,
                    icon: Icons.bar_chart_rounded,
                  ),
                  _buildModernStatTile(
                    title: 'Completed',
                    value: '${userData!['completedVideos']} videos', // Inchangé
                    color: Colors.purple,
                    icon: Icons.check_circle_outline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Barre Water Balance
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Water Balance',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.water_drop, color: Colors.blue),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (waterGlasses * glassSize) / dailyGoal,
                          color: Colors.blue,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${(waterGlasses * glassSize / 1000).toStringAsFixed(2)}L',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PracticeScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WaterTrackingScreen(
                  initialGlasses: waterGlasses,
                  onUpdateGlasses: _updateWaterGlasses,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator({
    required double percent,
    required String valueText,
    required String description,
    required Color progressColor,
  }) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 10.0,
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            valueText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: progressColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      progressColor: progressColor,
      backgroundColor: Colors.grey.shade300,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Widget _buildModernStatTile({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
