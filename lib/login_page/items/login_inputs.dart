import 'package:finmanage_mobile/repository/database_helper.dart';
import 'package:flutter/material.dart';

import '../../starter_page/main_screen.dart';

class InputsLogin extends StatefulWidget {
  const InputsLogin({super.key});

  @override
  _InputsLoginState createState() => _InputsLoginState();
}

class _InputsLoginState extends State<InputsLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final user = await DatabaseHelper.instance.getUser(email, password);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(user: user)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Digite seu e-mail';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Senha',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            validator: (password) {
              if (password == null || password.isEmpty) {
                return 'Digite sua senha';
              }
              return null;
            },
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF4C9581),
            ),
            child: const Text('Acessar'),
          ),
        ],
      ),
    );
  }
}