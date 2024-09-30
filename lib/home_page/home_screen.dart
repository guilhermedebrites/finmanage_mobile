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
  final double receita = 2450.0;
  final double despesa = 1520.0;

  List<Category> categories = [
    Category(name: 'Alimento', icon: Icons.fastfood, color: Colors.red, value: 200.0),
    Category(name: 'Transporte', icon: Icons.directions_car, color: Colors.blue, value: 150.0),
    Category(name: 'Entretenimento', icon: Icons.movie, color: Colors.green, value: 100.0),
    Category(name: 'Saúde', icon: Icons.local_hospital, color: Colors.purple, value: 70.0),
    Category(name: 'Educação', icon: Icons.school, color: Colors.orange, value: 50.0),
  ];

  @override
  Widget build(BuildContext context) {
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
                      ),
                    ],
                  ),
                ],
              ),
        )
    );
  }
}