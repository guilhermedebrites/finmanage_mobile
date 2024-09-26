import 'package:flutter/material.dart';

import 'box_icon.dart';
import 'box_info.dart';

class ContainerFinanceOverview extends StatelessWidget {
  final BoxIcon boxIcon;
  final BoxInfo boxInfo;
  final double? width;

  const ContainerFinanceOverview({
    super.key,
    required this.boxIcon,
    required this.boxInfo,
    this.width
  }) : super();

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
      width: MediaQuery.of(context).size.width * (width ?? 0.9),
      height: 65,
      child: Row(
        children: [
          boxIcon,
          const SizedBox(width: 10),
          boxInfo
        ],
      ),
    );
  }
}
