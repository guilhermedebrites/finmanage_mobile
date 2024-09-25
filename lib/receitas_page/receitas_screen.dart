import 'package:flutter/material.dart';

import '../bottom_menu.dart';

class ReceitasScreen extends StatelessWidget {
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
      ),
      bottomNavigationBar: const BottomMenu(), // Mover BottomMenu para bottomNavigationBar
    );
  }
}