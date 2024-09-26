import 'package:finmanage_mobile/despesas_page/despesas_screen.dart';
import 'package:finmanage_mobile/receitas_page/receitas_screen.dart';
import 'package:flutter/material.dart';

import '../home_page/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    DespesasScreen(),
    HomeScreen(),
    ReceitasScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 35,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.money_off),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
