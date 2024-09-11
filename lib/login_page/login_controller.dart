import 'package:finmanage_mobile/login_page/items/access_button.dart';
import 'package:finmanage_mobile/login_page/items/login_inputs.dart';
import 'package:flutter/material.dart';

class LoginController extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final bool? _isSigningIn;
  final Future<void> Function()? _signInWithGoogle;

  LoginController({
    super.key,
    required bool? isSigningIn,
    required Future<void> Function()? signInWithGoogle,
  })  : _isSigningIn = isSigningIn,
        _signInWithGoogle = signInWithGoogle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Column(
        children: [
          InputsLogin(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          const SizedBox(height: 20),
          AccessButton(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          const SizedBox(height: 8),
          if (_isSigningIn == true)
            const CircularProgressIndicator()
          else
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
