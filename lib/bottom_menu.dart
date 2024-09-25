import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'despesas_page/despesas_screen.dart';
import 'home_page/home_screen.dart';
import 'receitas_page/receitas_screen.dart';

import 'bottom_menu_provider.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomMenuBar();
  }
}

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({super.key});

  @override
  State<BottomMenuBar> createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onItemTapped(int index) {
    Provider.of<BottomMenuProvider>(context, listen: false).setSelectedIndex(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = Provider.of<BottomMenuProvider>(context).selectedIndex;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          Provider.of<BottomMenuProvider>(context, listen: false).setSelectedIndex(index);
        },
        physics: const NeverScrollableScrollPhysics(),
        children: [
          DespesasScreen(),
          HomeScreen(),
          ReceitasScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 18.0),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.money_off),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
          iconSize: 35,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
