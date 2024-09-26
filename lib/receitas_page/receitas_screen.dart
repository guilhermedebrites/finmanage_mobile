import 'package:flutter/material.dart';

class ReceitasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Container(
          child: const Center(
            child: Column(
              children: [
                Text(
                  'Receitas Screen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ) // Mover BottomMenu para bottomNavigationBar
    );
  }
}