import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/finManageLogo.png",
            width: 120,
            height: 120,
          ),
          const Text("FIN MANAGE",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                color: Color(0xFF4C9581),
              ))
        ],
      ),
    );
  }
}
