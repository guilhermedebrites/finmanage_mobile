import 'package:flutter/material.dart';

class HeaderSecondaryPages extends StatelessWidget {
  final String mainText;
  final String secondaryText;

  const HeaderSecondaryPages({super.key, required this.mainText, required this.secondaryText}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          secondaryText,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[500],
          ),
        ),
         Text(
           mainText,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
