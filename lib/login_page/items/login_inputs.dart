import 'package:finmanage_mobile/home_page/home_screen.dart';
import 'package:flutter/material.dart';

class InputsLogin extends StatefulWidget {
  const InputsLogin({super.key});

  @override
  _InputsLoginState createState() => _InputsLoginState();
}

class _InputsLoginState extends State<InputsLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


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
              if(email == null || email.isEmpty) {
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
              if(password == null || password.isEmpty) {
                return 'Digite sua senha';
              }
              return null;
            },
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if(_formKey.currentState!.validate()){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            },
            style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF4C9581),
            ),
            child: const Text('Acessar'),
          )
        ],
      ),
    );
  }

}
