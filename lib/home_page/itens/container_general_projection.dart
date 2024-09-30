import 'package:finmanage_mobile/home_page/itens/progress_bar.dart';
import 'package:finmanage_mobile/home_page/itens/text_general_projection.dart';
import 'package:flutter/material.dart';

class ContainerGeneralProjection extends StatelessWidget {
  final String incomeText;
  final String expenseText;
  final double redValue;
  final double greenValue;

  const ContainerGeneralProjection({
    super.key,
    required this.incomeText,
    required this.expenseText,
    required this.redValue,
    required this.greenValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'projeção geral',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 10),
                const TextGeneralProjection(
                  text1: 'receitas',
                  text2: 'despesas',
                  color1: Colors.green,
                  color2: Colors.red,
                ),
                const SizedBox(height: 4),
                TextGeneralProjection(
                  text1: incomeText,
                  text2: expenseText,
                  color1: Colors.green,
                  color2: Colors.red,
                ),
                const SizedBox(height: 10),
                ProgressBar(
                  redValue: redValue,
                  greenValue: greenValue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}