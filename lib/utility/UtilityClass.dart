import 'package:flutter/material.dart';

IconData getIconData(String iconName) {
  switch (iconName) {
    case 'Icons.fastfood':
      return Icons.fastfood;
    case 'Icons.directions_car':
      return Icons.directions_car;
    case 'Icons.home':
      return Icons.home;
    case 'Icons.local_hospital':
      return Icons.local_hospital;
    case 'Icons.school':
      return Icons.school;
    case 'Icons.sports_esports':
      return Icons.sports_esports;
    case 'Icons.shopping_cart':
      return Icons.shopping_cart;
    case 'Icons.receipt':
      return Icons.receipt;
    case 'Icons.trending_up':
      return Icons.trending_up;
    case 'Icons.flight':
      return Icons.flight;
    case 'Icons.family_restroom':
      return Icons.family_restroom;
    case 'Icons.volunteer_activism':
      return Icons.volunteer_activism;
    case 'Icons.account_balance':
      return Icons.account_balance;
    case 'Icons.attach_money':
      return Icons.attach_money;
    case 'Icons.more_horiz':
      return Icons.more_horiz;
    default:
      return Icons.help;
  }
}

Color getColor(String colorName) {
  switch (colorName) {
    case 'Colors.pink':
      return Colors.pink;
    case 'Colors.brown':
      return Colors.brown;
    case 'Colors.indigo':
      return Colors.indigo;
    case 'Colors.cyan':
      return Colors.cyan;
    case 'Colors.deepOrange':
      return Colors.deepOrange;
    case 'Colors.deepPurple':
      return Colors.deepPurple;
    case 'Colors.grey':
      return Colors.grey;
    case 'Colors.greenAccent':
      return Colors.greenAccent;
    case 'Colors.blueGrey':
      return Colors.blueGrey;
    default:
      return Colors.black;
  }
}