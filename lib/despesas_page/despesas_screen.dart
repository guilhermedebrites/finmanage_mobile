import 'package:flutter/material.dart';

class DespesasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: SingleChildScrollView(
        child: Container(
          child: const Center(
            child: Column(
              children: [
                Text(
                  'Despesas Screen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      )// Mover BottomMenu para bottomNavigationBar
    );
  }
}