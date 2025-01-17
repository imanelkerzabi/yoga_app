import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final cards = [
                      {
                        'title': 'Yoga Sessions',
                        'value': '12',
                        'icon': Icons.self_improvement,
                        'color': Colors.blue,
                      },
                      {
                        'title': 'Calories',
                        'value': '350 kcal',
                        'icon': Icons.local_fire_department,
                        'color': Colors.orange,
                      },
                      {
                        'title': 'Water',
                        'value': '2.5L',
                        'icon': Icons.water_drop,
                        'color': Colors.blue,
                      },
                      {
                        'title': 'Time',
                        'value': '45 min',
                        'icon': Icons.timer,
                        'color': Colors.purple,
                      },
                    ];
                    return _buildDashboardCard(
                      cards[index]['title'] as String,
                      cards[index]['value'] as String,
                      cards[index]['icon'] as IconData,
                      cards[index]['color'] as Color,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline), label: 'Sessions'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Water'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
      String title, String value, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // Action on card tap (e.g., navigate to details)
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
