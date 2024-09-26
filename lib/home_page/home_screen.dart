import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logo_header.dart';

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
                      SaldoAtualRow(),
                    ],
                  ),
                ],
              ),
        )// Mover BottomMenu para bottomNavigationBar
    );
  }
}

class SaldoAtualRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
          width: 360,
          height: 65,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                width: 45,
                height: 45,
                margin: const EdgeInsets.only(left: 10),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.wallet,
                    size: 24,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'saldo atual',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const Text(
                    'R\$2.132,55',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}