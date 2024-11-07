import 'package:finmanage_mobile/login_page/items/login_inputs.dart';
import 'package:finmanage_mobile/login_page/items/register_inputs.dart';
import 'package:flutter/material.dart';

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  bool _showRegister = false;

  void _toggleForm() {
    setState(() {
      _showRegister = !_showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Column(
        children: [
          if (_showRegister)
            const InputsRegister()
          else
            const InputsLogin(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleForm,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF4C9581),
            ),
            child: Text(_showRegister ? 'Voltar ao Login' : 'Cadastrar'),
          ),
        ],
      ),
    );
  }
}