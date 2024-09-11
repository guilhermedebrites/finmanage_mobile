import 'package:finmanage_mobile/database_helper.dart';
import 'package:flutter/material.dart';

class InputsLogin extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  InputsLogin({
    super.key,
    this.emailController,
    this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'E-mail',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Senha',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
