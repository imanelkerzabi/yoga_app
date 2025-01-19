import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String selectedGender = 'Female';
  DateTime selectedDate = DateTime.now();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Future<void> _updateUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'gender': selectedGender,
      'birthdate': '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      'weight': weightController.text.trim(),
      'height': heightController.text.trim(),
    });

    Navigator.pushNamed(context, '/level');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDropdown('Gender', ['Female', 'Male', 'Other'], selectedGender),
                    SizedBox(height: 20),
                    _buildTextField('Weight (kg)', weightController),
                    SizedBox(height: 20),
                    _buildTextField('Height (cm)', heightController),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateUserProfile,
                      child: Text('Update Profile'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String title, List<String> items, String currentValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        DropdownButton<String>(
          value: currentValue,
          isExpanded: true,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedGender = newValue;
              });
            }
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(() => controller.clear()),
              )
            : null,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
