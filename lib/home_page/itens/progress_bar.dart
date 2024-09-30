import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double redValue;
  final double greenValue;

  const ProgressBar({
    super.key,
    required this.redValue,
    required this.greenValue,
  }) : assert(redValue >= 0 && greenValue >= 0);

  @override
  Widget build(BuildContext context) {
    final totalValue = redValue + greenValue;

    return Stack(
      children: [
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: (greenValue / totalValue * 100).round(),
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: (redValue / totalValue * 100).round(),
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}