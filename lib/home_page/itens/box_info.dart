import 'package:flutter/material.dart';

class BoxInfo extends StatelessWidget {
  final String text;
  final String value;
  final double? fontSize;
  const BoxInfo({super.key, required this.text, required this.value, this.fontSize}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize ?? 24,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
