import 'package:finmanage_mobile/despesas_page/items/add_despesa_screen.dart';
import 'package:finmanage_mobile/despesas_page/items/header_secondary_pages.dart';
import 'package:finmanage_mobile/home_page/itens/box_icon.dart';
import 'package:flutter/material.dart';
import '../Category.dart';
import '../Despesa.dart';

class DespesasScreen extends StatefulWidget {
  final List<Despesa> despesas;
  final List<Category> categories;

  const DespesasScreen(
      {super.key, required this.despesas, required this.categories}) : super();

  @override
  _DespesasScreenState createState() => _DespesasScreenState();
}

class _DespesasScreenState extends State<DespesasScreen> {
  int _nextId = 1;

  void _addDespesa(Despesa novaDespesa) {
    setState(() {
      widget.despesas.add(novaDespesa);
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
                mainText: 'Despesas lançadas',
                secondaryText: 'transações',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.despesas.length,
              itemBuilder: (context, index) {
                final despesa = widget.despesas[index];
                final category = widget.categories
                    .firstWhere((category) =>
                widget.categories.indexOf(category) ==
                    despesa.idCategory - 1);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  child: ListTile(
                    leading: BoxIcon(
                      icon: category.icon,
                      colorIcon: category.color,
                      colorBackground: category.color.withOpacity(0.3),
                    ),
                    title: Text(despesa.name),
                    subtitle: Text('R\$ ${despesa.value.toStringAsFixed(2)}'),
                    trailing: Text(
                      '${despesa.date.day.toString().padLeft(2, '0')}/${despesa.date.month.toString().padLeft(2, '0')}/${despesa.date.year.toString()}',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 50),
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
                builder: (context) => AddDespesaScreen(
                  onAddDespesa: _addDespesa,
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
