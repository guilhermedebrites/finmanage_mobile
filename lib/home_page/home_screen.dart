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
    ),
    Despesa(
      id: 2,
      value: 50.0,
      name: 'Uber',
      idCategory: 2,
      idUser: 1,
    ),
    Despesa(
      id: 3,
      value: 20.0,
      name: 'Cinema',
      idCategory: 3,
      idUser: 1,
    ),
    Despesa(
      id: 4,
      value: 50.0,
      name: 'Remédio',
      idCategory: 4,
      idUser: 1,
    ),
    Despesa(
      id: 5,
      value: 100.0,
      name: 'Livro',
      idCategory: 5,
      idUser: 1,
    ),
  ];

  List<Receita> receitas = [
    Receita(
      id: 1,
      value: 1000.0,
      name: 'Salário',
      idCategory: 1,
      idUser: 1,
    ),
    Receita(
      id: 2,
      value: 50.0,
      name: 'Freelancer',
      idCategory: 2,
      idUser: 1,
    ),
    Receita(
      id: 3,
      value: 20.0,
      name: 'Venda',
      idCategory: 3,
      idUser: 1,
    ),
    Receita(
      id: 4,
      value: 50.0,
      name: 'Investimento',
      idCategory: 4,
      idUser: 1,
    ),
  ];

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
                    ],
                  ),
                ],
              ),
        )
    );
  }
}