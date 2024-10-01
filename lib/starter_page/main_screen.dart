import 'package:finmanage_mobile/despesas_page/despesas_screen.dart';
import 'package:finmanage_mobile/receitas_page/receitas_screen.dart';
import 'package:flutter/material.dart';

import '../Category.dart';
import '../Despesa.dart';
import '../Receita.dart';
import '../home_page/home_screen.dart';

List<Category> categories = [
  Category(name: 'Alimento', icon: Icons.fastfood, color: Colors.red),
  Category(name: 'Transporte', icon: Icons.directions_car, color: Colors.blue),
  Category(name: 'Entretenimento', icon: Icons.movie, color: Colors.green),
  Category(name: 'Saúde', icon: Icons.local_hospital, color: Colors.purple),
  Category(name: 'Educação', icon: Icons.school, color: Colors.orange),
];

List<Despesa> despesas = [
  Despesa(
    id: 1,
    value: 100.0,
    name: 'Almoço',
    idCategory: 1,
    idUser: 1,
    date: DateTime.now(),
  ),
  Despesa(
    id: 2,
    value: 50.0,
    name: 'Uber',
    idCategory: 2,
    idUser: 1,
    date: DateTime.now(),
  ),
  Despesa(
    id: 3,
    value: 20.0,
    name: 'Cinema',
    idCategory: 3,
    idUser: 1,
    date: DateTime.now(),
  ),
  Despesa(
    id: 4,
    value: 50.0,
    name: 'Remédio',
    idCategory: 4,
    idUser: 1,
    date: DateTime.now(),
  ),
  Despesa(
    id: 5,
    value: 100.0,
    name: 'Livro',
    idCategory: 5,
    idUser: 1,
    date: DateTime(1999, 12, 31),
  ),
  Despesa(
    id: 6,
    value: 100.0,
    name: 'Hospital',
    idCategory: 3,
    idUser: 1,
    date: DateTime(1999, 12, 31),
  ),
];

List<Receita> receitas = [
  Receita(
    id: 1,
    value: 1000.0,
    name: 'Salário',
    idCategory: 1,
    idUser: 1,
    date: DateTime.now(),
  ),
  Receita(
    id: 2,
    value: 50.0,
    name: 'Freelancer',
    idCategory: 2,
    idUser: 1,
    date: DateTime.now(),
  ),
  Receita(
    id: 3,
    value: 20.0,
    name: 'Venda',
    idCategory: 3,
    idUser: 1,
    date: DateTime.now(),
  ),
  Receita(
    id: 4,
    value: 50.0,
    name: 'Investimento',
    idCategory: 4,
    idUser: 1,
    date: DateTime.now(),
  ),
];

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    DespesasScreen(
      despesas: despesas,
      categories: categories,
    ),
    HomeScreen(
      despesas: despesas,
      receitas: receitas,
      categories: categories,
    ),
    ReceitasScreen(
      receitas: receitas,
      categories: categories,
    ),
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
