import 'package:firebase_database/firebase_database.dart';
import '../Category.dart';
import '../Despesa.dart';
import '../Receita.dart';
import '../utility/UtilityClass.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  Future<List<Despesa>> getDespesas(String userId) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('despesas');
    final DataSnapshot snapshot = await ref.orderByChild('idUser').equalTo(userId).get();

    final List<Despesa> despesas = [];
    for (var child in snapshot.children) {
      final despesa = Despesa(
        id: child.key,
        value: child.child('value').value != null ? (child.child('value').value as num).toDouble() : 0.0,
        name: child.child('name').value != null ? child.child('name').value as String : '',
        idCategory: child.child('idCategory').value != null ? child.child('idCategory').value as int : 0,
        idUser: child.child('idUser').value != null ? child.child('idUser').value as String : '',
        date: child.child('date').value != null ? DateTime.parse(child.child('date').value as String) : DateTime.now(),
      );
      despesas.add(despesa);
    }
    return despesas;
  }

  Future<List<Receita>> getReceitas(String userId) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('receitas');
    final DataSnapshot snapshot = await ref.orderByChild('idUser').equalTo(userId).get();

    final List<Receita> receitas = [];
    for (var child in snapshot.children) {
      final receita = Receita(
        id: child.key,
        value: child.child('value').value != null ? (child.child('value').value as num).toDouble() : 0.0,
        name: child.child('name').value != null ? child.child('name').value as String : '',
        idCategory: child.child('idCategory').value != null ? child.child('idCategory').value as int : 0,
        idUser: child.child('idUser').value != null ? child.child('idUser').value as String : '',
        date: child.child('date').value != null ? DateTime.parse(child.child('date').value as String) : DateTime.now(),
      );
      receitas.add(receita);
    }
    return receitas;
  }

  Future<void> insertDespesa(Despesa despesa) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('despesas');
    await ref.push().set(despesa.toMap());
  }

  Future<void> insertReceita(Receita receita) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('receitas');
    await ref.push().set(receita.toMap());
  }

  Future<void> deleteDespesa(String id) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('despesas/$id');
    await ref.remove();
  }

  Future<void> deleteReceita(String id) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('receitas/$id');
    await ref.remove();
  }

  Future<void> updateDespesa(Despesa despesa) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('despesas/${despesa.id}');
    await ref.update(despesa.toMap());
  }

  Future<void> updateReceita(Receita receita) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('receitas/${receita.id}');
    await ref.update(receita.toMap());
  }

  Future<List<Category>> getCategorias() async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('categorias');
    final DataSnapshot snapshot = await ref.get();

    final List<Category> categories = [];
    for (var child in snapshot.children) {
      final category = Category(
        id: child.child('id').value as int,
        name: child.child('name').value as String,
        icon: getIconData(child.child('icon').value as String),
        color: getColor(child.child('color').value as String),
      );
      categories.add(category);
    }
    return categories;
  }

}