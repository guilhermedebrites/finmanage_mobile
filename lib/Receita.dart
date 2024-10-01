import 'package:flutter/material.dart';

class Receita {
  final int id;
  final double value;
  final int idCategory;
  final int idUser;
  final String name;
  final DateTime date;

  Receita({
    required this.id,
    required this.value,
    required this.idCategory,
    required this.idUser,
    required this.name,
    required this.date,
  });
}