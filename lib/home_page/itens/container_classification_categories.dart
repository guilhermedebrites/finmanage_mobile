import 'package:finmanage_mobile/home_page/itens/box_info.dart';
import 'package:flutter/material.dart';
import '../../Category.dart';
import '../../Despesa.dart';
import 'box_icon.dart';

class ContainerClassificationCategories extends StatelessWidget {
  final List<Category> categories;
  final List<Despesa> despesas;

  const ContainerClassificationCategories({
    super.key,
    required this.categories,
    required this.despesas,
  });

  Map<Category, double> calcularGastosPorCategoria() {
    Map<Category, double> gastosPorCategoria = {};

    for (var category in categories) {
      gastosPorCategoria[category] = 0.0;

      for (var despesa in despesas) {
        if (despesa.idCategory == categories.indexOf(category) + 1) {
          gastosPorCategoria[category] = gastosPorCategoria[category]! + despesa.value;
        }
      }
    }

    var sortedCategories = Map.fromEntries(
      gastosPorCategoria.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value)),
    );

    return sortedCategories;
  }

  @override
  Widget build(BuildContext context) {
    Map<Category, double> gastosPorCategoria = calcularGastosPorCategoria();

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorias mais gastas',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: gastosPorCategoria.entries.map((entry) {
              Category category = entry.key;
              double totalGasto = entry.value;

              return Column(
                children: [
                  Row(
                    children: [
                      BoxIcon(
                        icon: category.icon,
                        colorIcon: category.color,
                        colorBackground: category.color.withOpacity(0.3),
                      ),
                      const SizedBox(width: 10),
                      BoxInfo(
                        text: category.name,
                        value: 'R\$${totalGasto.toStringAsFixed(2)}',
                        fontSize: 15,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
