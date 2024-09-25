import 'package:flutter/material.dart';

class InputsRegister extends StatefulWidget {
  const InputsRegister({super.key});

  @override
  _InputsRegisterState createState() => _InputsRegisterState();
}

class _InputsRegisterState extends State<InputsRegister> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF4C9581),
            ),
            child: const Text('Registrar'),
          )
        ],
    );
  }

}
