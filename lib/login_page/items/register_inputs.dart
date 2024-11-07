import 'package:finmanage_mobile/repository/database_helper.dart';
import 'package:flutter/material.dart';

import '../../User.dart';

class InputsRegister extends StatefulWidget {
  const InputsRegister({super.key});

  @override
  _InputsRegisterState createState() => _InputsRegisterState();
}

class _InputsRegisterState extends State<InputsRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      final user = User(name: name, email: email, password: password);
      await DatabaseHelper.instance.addUser(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User registered successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            validator: (name) {
              if (name == null || name.isEmpty) {
                return 'Digite seu nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
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
            onPressed: _register,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF4C9581),
            ),
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }
}