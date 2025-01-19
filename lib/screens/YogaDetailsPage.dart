import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yoga_app/screens/ActiveSessionScreen.dart';


class YogaDetailsPage extends StatefulWidget {
  const YogaDetailsPage({super.key});

  @override
  State<YogaDetailsPage> createState() => _YogaDetailsPageState();
}

class _YogaDetailsPageState extends State<YogaDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA), // Couleur lavande claire
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    _buildIconButton(
                      icon: Icons.arrow_back,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      "Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF4A4A8F),
                      ),
                    ),
                    const Spacer(),
                    _buildIconButton(
                      icon: Icons.favorite_border,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // Image
              Container(
                margin: const EdgeInsets.all(16),
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFB4B4C7), // Couleur grise pastel
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const Gap(16),
              // Informations
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "5 Min Morning Yoga to FEEL AMAZING!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF4A4A8F),
                      ),
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    size: 16, color: Color(0xFFFFD700)),
                                Gap(4),
                                Text("3.8",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4A4A8F))),
                                Gap(8),
                                Text("(124 reviews)",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFB4B4C7))),
                              ],
                            ),
                            Gap(8),
                            Row(
                              children: [
                                Icon(Icons.access_time_filled_outlined,
                                    size: 16, color: Color(0xFF6C63FF)),
                                Gap(4),
                                Text("5 mins",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF4A4A8F))),
                                Gap(8),
                                Icon(Icons.local_fire_department_outlined,
                                    size: 16, color: Color(0xFFFF4500)),
                                Gap(4),
                                Text("312 kcal",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF4A4A8F))),
                              ],
                            ),
                          ],
                        ),
                        _buildIconButton(
                          icon: Icons.play_arrow,
                          onPressed: () {},
                          backgroundColor: const Color(0xFF6C63FF),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(24),
              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Experience the transformative power of yoga with our Inner Healing Therapy. "
                  "This session focuses on enhancing your mental clarity, emotional stability, and physical strength.",
                  style: TextStyle(fontSize: 14, color: Color(0xFF4A4A8F)),
                ),
              ),
              const Gap(24),
              // Niveau et Progrès
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard("Level", "1"),
                    _buildStatCard("Progress", "10%"),
                    _buildStatCard("Duration", "5 mins"),
                  ],
                ),
              ),
              const Gap(24),
              // Bouton Start Training
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ActiveSessionScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Start Training",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  // Widgets auxiliaires
  Widget _buildIconButton(
      {required IconData icon,
      required VoidCallback onPressed,
      Color backgroundColor = const Color(0xFFB4B4C7)}) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(8)),
      child: IconButton(
          icon: Icon(icon, color: Colors.white), onPressed: onPressed),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF4A4A8F)),
        ),
        const Gap(4),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xFFB4B4C7)),
        ),
      ],
    );
  }
}


