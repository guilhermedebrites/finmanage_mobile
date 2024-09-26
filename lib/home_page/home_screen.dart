import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logo_header.dart';
import 'itens/box_icon.dart';
import 'itens/box_info.dart';
import 'itens/container_finance_overview.dart';

class HomeScreen extends StatelessWidget {
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
                      const ContainerFinanceOverview(
                        boxIcon: BoxIcon(),
                        boxInfo: BoxInfo(
                            text: 'saldo atual',
                            value: 'R\$2.132,55'
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
                            boxInfo: const BoxInfo(
                              text: 'receitas',
                              value: 'R\$2.132,55',
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
                            boxInfo: const BoxInfo(
                                text: 'despesas',
                                value: 'R\$2.132,55',
                                fontSize: 20
                            ),
                            width: 0.44,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
        )
    );
  }
}