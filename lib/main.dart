import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/screens/ActiveSessionScreen.dart';
import 'package:yoga_app/screens/WaterTrackingScreen.dart';
import 'package:yoga_app/screens/YogaDetailsPage.dart';
import 'package:yoga_app/screens/flow_yoga_screen.dart';
import 'package:yoga_app/screens/practice_screen.dart';
import 'package:yoga_app/screens/signin_screen.dart';
import 'package:yoga_app/screens/HomeScreen.dart';
import 'package:yoga_app/screens/start_screen.dart';
import 'package:yoga_app/screens/user_profile_screen.dart';
import 'package:yoga_app/screens/welcom_screen';
import 'package:yoga_app/screens/yoga_level_screen.dart';
import 'package:yoga_app/service/AutheService.dart';
import 'package:yoga_app/screens/signup_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
              '/': (context) => const WelcomeScreen(),
              '/signin': (context) => const SignInScreen(),
              '/signup': (context) => SignUpScreen(),
              '/user': (context) => const UserProfileScreen(),
              '/level': (context) => const YogaLevelScreen(),
              '/home': (context) => const HomeScreen(),
              '/start': (context) => const StartScreen(),
              '/practice': (context) => const PracticeScreen(),
              '/session': (context) => const ActiveSessionScreen(),
              '/flowYoga': (context) => const FlowYogaScreen(),
              '/details': (context) => const YogaDetailsPage(),
              '/water': (context) => WaterTrackingScreen(
                    initialGlasses: 0, // Valeur par défaut
                    onUpdateGlasses: (int glasses) {
                      print('Updated glasses: $glasses'); // Exemple de mise à jour
                    },
                  ),
            }
            )
            );
  }
}
