import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtenir l'utilisateur actuel
  User? get currentUser => _auth.currentUser;

  // Stream de l'état de l'authentification
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Inscription avec email et mot de passe
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Créer un document utilisateur dans Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Notifie les listeners que l'état a changé
      notifyListeners();

      return userCredential;
    } catch (e) {
      throw Exception('Erreur lors de l\'inscription : ${e.toString()}');
    }
  }

  // Connexion avec email et mot de passe
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Notifie les listeners que l'état a changé
      notifyListeners();

      return userCredential;
    } catch (e) {
      throw Exception('Erreur lors de la connexion : ${e.toString()}');
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    try {
      await _auth.signOut();

      // Notifie les listeners que l'état a changé
      notifyListeners();
    } catch (e) {
      throw Exception('Erreur lors de la déconnexion : ${e.toString()}');
    }
  }
}
