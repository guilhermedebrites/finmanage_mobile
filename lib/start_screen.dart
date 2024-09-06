import 'package:flutter/material.dart';

import 'login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF4C9581),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/finManageLogo.png",
                width: 257,
                height: 257,
              ),
              const Text("FIN MANAGE",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inder',
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 100),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          )
      ),
    );
  }
}