import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height, // Ensure container fills the screen
        width: MediaQuery.of(context).size.width, // Ensure container fills the screen
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/page1.jpg'),
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align children to the end of the main axis
          crossAxisAlignment: CrossAxisAlignment.center, // Center children horizontally
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // Adjust the padding as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Let's start!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
