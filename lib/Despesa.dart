class Despesa {
  final String? id;
  final double value;
  final String name;
  final int idCategory;
  final String idUser;
  final DateTime date;

  Despesa({
    this.id,
    required this.value,
    required this.idCategory,
    required this.idUser,
    required this.name,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'name': name,
      'idCategory': idCategory,
      'idUser': idUser,
      'date': date.toIso8601String(),
    };
  }
}