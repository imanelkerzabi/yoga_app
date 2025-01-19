import 'package:flutter/material.dart';

class WaterTrackingScreen extends StatefulWidget {
  final int initialGlasses;
  final Function(int) onUpdateGlasses;

  const WaterTrackingScreen({
    Key? key,
    required this.initialGlasses,
    required this.onUpdateGlasses,
  }) : super(key: key);

  @override
  State<WaterTrackingScreen> createState() => _WaterTrackingScreenState();
}

class _WaterTrackingScreenState extends State<WaterTrackingScreen> {
  late int waterGlasses;

  @override
  void initState() {
    super.initState();
    waterGlasses = widget.initialGlasses;
  }

  void _addGlass() {
    setState(() {
      waterGlasses++;
    });
    widget.onUpdateGlasses(waterGlasses);
  }

  void _removeGlass() {
    if (waterGlasses > 0) {
      setState(() {
        waterGlasses--;
      });
      widget.onUpdateGlasses(waterGlasses);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (waterGlasses * 250) / 2000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Titre
            const Text(
              'Track Your Water Intake',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C63FF),
              ),
            ),
            const SizedBox(height: 30),

            // Animation de verre d'eau
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 150,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  width: 150,
                  height: progress * 300, // Remplissage basé sur la progression
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.6),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Volume d'eau consommé
            Text(
              '${waterGlasses * 250} ml (${(waterGlasses * 250 / 1000).toStringAsFixed(2)} L)',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C63FF),
              ),
            ),
            const SizedBox(height: 20),

            // Barre de progression
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
              minHeight: 12,
            ),
            const SizedBox(height: 20),

            // Objectif journalier
            Text(
              'Daily Goal: 2000 ml',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // Boutons pour ajouter ou retirer des verres
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _removeGlass,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(Icons.remove, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _addGlass,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(Icons.add, size: 30, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Message d'encouragement
            if (progress < 1.0)
              const Text(
                'Keep Going! Stay Hydrated 💧',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              )
            else
              const Text(
                'Congratulations! 🎉 You’ve reached your goal!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),

      // BottomNavigationBar avec des icônes modernes
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context); // Retour à l'écran précédent
          } else if (index == 1) {
            // Exemple de navigation vers un autre écran
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WaterTrackingScreen(
                  initialGlasses: waterGlasses,
                  onUpdateGlasses: (int updatedGlasses) {
                    setState(() {
                      waterGlasses = updatedGlasses;
                    });
                  },
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            label: 'Water',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
