import 'package:finmanage_mobile/database_helper.dart';
import 'package:finmanage_mobile/home_screen.dart';
import 'package:flutter/material.dart';

class AccessButton extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  AccessButton({
    super.key,
    this.emailController,
    this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController?.text ?? '';
        final password = passwordController?.text ?? '';

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-mail ou senha vazios')),
          );
          return;
        }

        // Verifique se o usuário existe no banco de dados
        final user = await _dbHelper.getUser(email, password);

        if (user != null) {
          // Login bem-sucedido
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais inválidas')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF4C9581),
      ),
      child: const Text('Acessar'),
    );
  }
}
