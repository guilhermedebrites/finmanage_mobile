import 'package:flutter/material.dart';
import '../bottom_menu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Home Screen',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}