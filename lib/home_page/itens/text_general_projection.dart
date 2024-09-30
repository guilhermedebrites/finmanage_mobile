import 'package:flutter/material.dart';

class TextGeneralProjection extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? color1;
  final Color? color2;
  const TextGeneralProjection({super.key, required this.text1, required this.text2, required this.color1, required this.color2}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(
            color: color1 ?? Colors.grey[300],
            fontSize: 14,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: color2 ?? Colors.grey[300],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
