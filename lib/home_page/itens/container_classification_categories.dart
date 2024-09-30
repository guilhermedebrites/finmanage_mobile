import 'package:finmanage_mobile/home_page/itens/box_info.dart';
import 'package:flutter/material.dart';

import '../../Category.dart';
import 'box_icon.dart';

class ContainerClassificationCategories extends StatelessWidget {

  final List<Category> categories;

  const ContainerClassificationCategories({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
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
            'categorias mais gastas',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: categories.map((category) {
              return Row(
                children: [
                  BoxIcon(
                    icon: category.icon,
                    colorIcon: category.color,
                    colorBackground: category.color.withOpacity(0.3),
                  ),
                  const SizedBox(width: 10),
                  BoxInfo(
                    text: category.name,
                    value: 'R\$${category.value.toStringAsFixed(2)}',
                    fontSize: 15,
                  ),
                  const SizedBox(height: 60),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}