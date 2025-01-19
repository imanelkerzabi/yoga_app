import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YogaLevelScreen extends StatefulWidget {
  const YogaLevelScreen({Key? key}) : super(key: key);

  @override
  State<YogaLevelScreen> createState() => _YogaLevelScreenState();
}

class _YogaLevelScreenState extends State<YogaLevelScreen> {
  int selectedLevel = -1;
  final levels = ['Beginner', 'Experienced Beginner', 'Intermediate', 'Advanced'];

  Future<void> _updateYogaLevel() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'level': levels[selectedLevel],
    });

    Navigator.pushNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Yoga Level'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'What is your yoga level?',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20),
                ...List.generate(
                  levels.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => selectedLevel = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: selectedLevel == index ? Colors.blue[100] : Colors.white,
                        border: Border.all(
                          color: selectedLevel == index ? Colors.blue : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          if (selectedLevel == index)
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.5),
                              blurRadius: 8.0,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            levels[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selectedLevel == index ? Colors.blue[800] : Colors.black,
                            ),
                          ),
                          if (selectedLevel == index)
                            const Icon(Icons.check_circle, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: selectedLevel != -1 ? _updateYogaLevel : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
