import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Category.dart';
import '../Despesa.dart';
import '../Receita.dart';
import '../despesas_page/despesas_screen.dart';
import '../home_page/home_screen.dart';
import '../receitas_page/receitas_screen.dart';
import '../repository/database_helper.dart';
import '../utility/UtilityClass.dart';

class MainScreen extends StatefulWidget {
  final User user;

  MainScreen({required this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  Future<List<Category>> getCategorias() async {
    return await DatabaseHelper.instance.getCategorias();
  }

  Future<List<Despesa>> getDespesas(String userId) async {
    return await DatabaseHelper.instance.getDespesas(userId);
  }

  Future<List<Receita>> getReceitas(String userId) async {
    return await DatabaseHelper.instance.getReceitas(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        getCategorias(),
        getDespesas(widget.user.uid),
        getReceitas(widget.user.uid)
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          print('Stack Trace: ${snapshot.stackTrace}');
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          List<Category> categories = snapshot.data![0];
          List<Despesa> despesas = snapshot.data![1];
          List<Receita> receitas = snapshot.data![2];

          final List<Widget> _screens = [
            DespesasScreen(
              userId: widget.user.uid,
              categories: categories,
            ),
            HomeScreen(
              despesas: despesas,
              receitas: receitas,
              categories: categories,
            ),
            ReceitasScreen(
              userId: widget.user.uid,
              categories: categories,
            ),
          ];

          return Scaffold(
            body: _screens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.money_off),
                  label: 'Despesas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money),
                  label: 'Receitas',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}