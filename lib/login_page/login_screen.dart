import 'package:finmanage_mobile/login_page/login_controller.dart';
import 'package:finmanage_mobile/logo_header.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7D7D7),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogoHeader(),
              const Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginController(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}