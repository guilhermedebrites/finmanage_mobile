import 'package:finmanage_mobile/login_page/items/login_inputs.dart';
import 'package:finmanage_mobile/login_page/items/register_inputs.dart';
import 'package:flutter/material.dart';

class LoginController extends StatelessWidget {
  const LoginController({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 340,
      child: Column(
        children: [
          InputsLogin(),
          InputsRegister()
        ],
      ),
    );
  }
}
