import 'package:flutter/material.dart';

class Despesa {
  final int id;
  final double value;
  final String name;
  final int idCategory;
  final int idUser;
  final DateTime date;

  Despesa({
    required this.id,
    required this.value,
    required this.idCategory,
    required this.idUser,
    required this.name,
    required this.date,
  });
}