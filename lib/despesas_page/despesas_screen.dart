import 'package:finmanage_mobile/despesas_page/items/header_secondary_pages.dart';
import 'package:finmanage_mobile/home_page/itens/box_icon.dart';
import 'package:flutter/material.dart';
import '../Category.dart';
import '../Despesa.dart';

class DespesasScreen extends StatelessWidget {
  final List<Despesa> despesas;
  final List<Category> categories;

  const DespesasScreen({super.key, required this.despesas, required this.categories}) : super();

  Category getCategoryById(int idCategory) {
    return categories.firstWhere((category) => categories.indexOf(category) == idCategory - 1);
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
              itemCount: despesas.length,
              itemBuilder: (context, index) {
                final despesa = despesas[index];
                final category = getCategoryById(despesa.idCategory);

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
    );
  }
}
