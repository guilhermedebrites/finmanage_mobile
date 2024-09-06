import 'package:finmanage_mobile/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigningIn = false;

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha ao autenticar com Google.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login com Google: $e')),
      );
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD7D7D7),
      body: Center(
        child: Column(
          children: [
            LogoHeader(),
            const SizedBox(height: 200),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginFormState(),
                const SizedBox(height: 8),
                if (_isSigningIn) const CircularProgressIndicator() else ElevatedButton(
                      onPressed: _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF4C9581),
                      ),
                      child: const Text('Entrar com Google'),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}

class LoginFormState extends StatelessWidget  {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
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
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu e-mail';
              }
              // Adicione validação adicional de e-mail se necessário
              return null;
            },
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
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua senha';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 340,
            child: ElevatedButton(
              onPressed: () {
                // Adicione a lógica de login aqui
                final email = _emailController.text;
                final password = _passwordController.text;
                print('E-mail: $email');
                print('Senha: $password');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF4C9581),
              ),
              child: Text('Acessar'),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Image.asset("assets/images/finManageLogo.png",
          width: 120,
          height: 120,
        ),
        const Text("FIN MANAGE",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20,
            color: Color(0xFF4C9581),
          )
        )
       ],
     ),
   );
  }
}
