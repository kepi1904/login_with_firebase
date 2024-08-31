import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/home_page.dart';
import 'package:login_with_firebase/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBUUtf1YcNLjIaAY8NE2PVfHx3Cp8QF_fU",
          appId: "1:177743511769:android:d764abfc9fd8b3db933ec8",
          messagingSenderId: "177743511769",
          projectId: "loginfirebase-4a1ad"));
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MaterialApp(
        home: AuthWrapper(),
      ),
    ),
  ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (auth.currentUser!.email != null) {
        return const HomePage();
      } else {
        return const LoginPage();
      }
    } catch (e) {
      return const LoginPage();
    }
  }
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get autStateChanges => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
