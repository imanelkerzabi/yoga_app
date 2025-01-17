import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/screens/signin_screen.dart';
import 'package:yoga_app/screens/HomeScreen.dart';
import 'package:yoga_app/service/AutheService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Erreur lors de l\'initialisation de Firebase : $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yoga App',
        theme: ThemeData(
          primaryColor: const Color(0xFF4A4A8F),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF6C63FF),
            foregroundColor: Colors.white,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SignInScreen(),
          '/home': (context) => const  HomeScreen(),
        },
      ),
    );
  }
}
