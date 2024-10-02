import 'package:finmanage_mobile/Receita.dart';
import 'package:finmanage_mobile/despesas_page/items/header_secondary_pages.dart';
import 'package:finmanage_mobile/home_page/itens/box_icon.dart';
import 'package:flutter/material.dart';
import '../Category.dart';
import 'package:finmanage_mobile/receitas_page/add_receita_screen.dart';


class ReceitasScreen extends StatefulWidget {
  final List<Receita> receitas;
  final List<Category> categories;

  const ReceitasScreen(
      {super.key, required this.receitas, required this.categories})
      : super();

  @override
  _ReceitasScreenState createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  int _nextId = 1;

  void _addReceita(Receita novaReceita) {
    setState(() {
      widget.receitas.add(novaReceita);
      _nextId++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7D7D7),
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: const HeaderSecondaryPages(
                mainText: 'Receitas lançadas',
                secondaryText: 'transações',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.receitas.length,
              itemBuilder: (context, index) {
                final receita = widget.receitas[index];
                final category = widget.categories
                    .firstWhere((category) =>
                widget.categories.indexOf(category) ==
                    receita.idCategory - 1);

                return Card(
                  margin:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  child: ListTile(
                    leading: BoxIcon(
                      icon: category.icon,
                      colorIcon: category.color,
                      colorBackground: category.color.withOpacity(0.3),
                    ),
                    title: Text(receita.name),
                    subtitle: Text('R\$ ${receita.value.toStringAsFixed(2)}'),
                    trailing: Text(
                      '${receita.date.day.toString().padLeft(2, '0')}/${receita.date.month.toString().padLeft(2, '0')}/${receita.date.year.toString()}',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 66),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0), // Adjust the value as needed
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddReceitaScreen(
                  onAddReceita: _addReceita,
                  nextId: _nextId,
                ),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.green),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}