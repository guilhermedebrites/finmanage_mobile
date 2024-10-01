import 'package:finmanage_mobile/Despesa.dart';
import 'package:finmanage_mobile/Receita.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Category.dart';
import '../logo_header.dart';
import 'itens/box_icon.dart';
import 'itens/box_info.dart';
import 'itens/container_classification_categories.dart';
import 'itens/container_finance_overview.dart';
import 'itens/container_general_projection.dart';
class HomeScreen extends StatelessWidget {
  final List<Despesa> despesas;
  final List<Receita> receitas;
  final List<Category> categories;

  const HomeScreen({super.key, required this.despesas, required this.receitas, required this.categories}) : super();


  double calcularTotalReceita(List<Receita> receitas) {
    double total = 0.0;
    for (var receita in receitas) {
      total += receita.value;
    }
    return total;
  }

  double calcularTotalDespesa(List<Despesa> despesas) {
    double total = 0.0;
    for (var despesa in despesas) {
      total += despesa.value;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final double receita = calcularTotalReceita(receitas);
    final double despesa = calcularTotalDespesa(despesas);

    return Scaffold(
        backgroundColor: const Color(0xFFD7D7D7),
        body: SingleChildScrollView(
              child: Column(
                children: [
                  LogoHeader(),
                  Column(
                    children: [
                      ContainerFinanceOverview(
                        boxIcon: const BoxIcon(),
                        boxInfo: BoxInfo(
                            text: 'saldo atual',
                            value: 'R\$${(receita - despesa).toStringAsFixed(2)}',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContainerFinanceOverview(
                            boxIcon: BoxIcon(
                              icon: FontAwesomeIcons.moneyBill,
                              colorIcon: Colors.green[500],
                              colorBackground: Colors.green[300]),
                            boxInfo: BoxInfo(
                              text: 'receitas',
                              value: 'R\$${receita.toStringAsFixed(2)}',
                              fontSize: 20
                            ),
                            width: 0.44,
                          ),
                          const SizedBox(width: 10),
                          ContainerFinanceOverview(
                            boxIcon: BoxIcon(
                                icon: FontAwesomeIcons.moneyBill,
                                colorIcon: Colors.red[500],
                                colorBackground: Colors.red[300]),
                            boxInfo: BoxInfo(
                                text: 'despesas',
                                value: 'R\$${despesa.toStringAsFixed(2)}',
                                fontSize: 20
                            ),
                            width: 0.44,
                          )
                        ],
                      ),
                      ContainerGeneralProjection(
                        incomeText: 'R\$${receita.toStringAsFixed(2)}',
                        expenseText: 'R\$${despesa.toStringAsFixed(2)}',
                        redValue: despesa,
                        greenValue: receita,
                      ),
                      ContainerClassificationCategories(
                        categories: categories,
                        despesas: despesas,
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
        )
    );
  }
}