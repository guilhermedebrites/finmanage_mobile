import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../starter_page/main_screen.dart';

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      var user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(user: user)),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login: ${e.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _signInWithGoogle,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF4C9581),
            ),
            child: const Text('Entrar com Google'),
          ),
        ],
      ),
    );
  }
}