import 'package:flutter/material.dart';

import '../Category.dart';
import '../Despesa.dart';
import '../Receita.dart';
import '../User.dart';
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
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('categorias');

    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
        icon: getIconData(maps[i]['icon']),
        color: getColor(maps[i]['color']),
      );
    });
  }

  Future<List<Despesa>> getDespesas(int userId) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('despesas', where: 'idUser = ?', whereArgs: [userId]);

    return List.generate(maps.length, (i) {
      return Despesa(
        id: maps[i]['id'],
        value: maps[i]['value'],
        name: maps[i]['name'],
        idCategory: maps[i]['idCategory'],
        idUser: maps[i]['idUser'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<List<Receita>> getReceitas(int userId) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('receitas', where: 'idUser = ?', whereArgs: [userId]);

    return List.generate(maps.length, (i) {
      return Receita(
        id: maps[i]['id'],
        value: maps[i]['value'],
        name: maps[i]['name'],
        idCategory: maps[i]['idCategory'],
        idUser: maps[i]['idUser'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        getCategorias(),
        getDespesas(widget.user.id!),
        getReceitas(widget.user.id!)
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
              userId: widget.user.id!,
              categories: categories,
            ),
            HomeScreen(
              despesas: despesas,
              receitas: receitas,
              categories: categories,
            ),
            ReceitasScreen(
              userId: widget.user.id!,
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