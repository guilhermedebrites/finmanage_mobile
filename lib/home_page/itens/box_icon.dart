import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoxIcon extends StatelessWidget {
  final Color? colorBackground;
  final Color? colorIcon;
  final IconData? icon;
  const BoxIcon({super.key, this.colorBackground, this.colorIcon, this.icon}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorBackground ?? Colors.grey[300],
        ),
        width: 45,
        height: 45,
        margin: const EdgeInsets.only(left: 10),
        child: Center(
          child: FaIcon(
            icon ?? FontAwesomeIcons.wallet,
            size: 24,
            color: colorIcon ?? Colors.grey[500],
          ),
        ),
      );
  }
}
