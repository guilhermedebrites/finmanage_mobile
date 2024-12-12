import 'package:finmanage_mobile/Despesa.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../repository/database_helper.dart';

class AddDespesaScreen extends StatefulWidget {
  final Function(Despesa) onAddDespesa;
  final int nextId;
  final String userId;
  final Despesa? despesaParaEditar;

  const AddDespesaScreen({
    super.key,
    required this.onAddDespesa,
    required this.nextId,
    required this.userId,
    this.despesaParaEditar,
  });

  @override
  _AddDespesaScreenState createState() => _AddDespesaScreenState();
}

class _AddDespesaScreenState extends State<AddDespesaScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.despesaParaEditar != null) {
      _nameController.text = widget.despesaParaEditar!.name;
      _valueController.text = widget.despesaParaEditar!.value.toString();
      _categoryController.text = widget.despesaParaEditar!.idCategory.toString();
      _dateController.text = widget.despesaParaEditar!.date.toIso8601String().split('T')[0];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _saveDespesa() async {
    final String name = _nameController.text;
    final double? value = double.tryParse(_valueController.text);
    final int category = int.tryParse(_categoryController.text) ?? 1;
    final DateTime? date = DateTime.tryParse(_dateController.text);

    if (name.isNotEmpty && value != null && date != null) {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('categorias');
      final DataSnapshot snapshot = await ref.orderByChild('id').equalTo(category).get();

      if (snapshot.exists) {
        Despesa despesa;
        if (widget.despesaParaEditar != null) {
          despesa = Despesa(
            id: widget.despesaParaEditar!.id,
            value: value,
            idCategory: category,
            idUser: widget.userId,
            name: name,
            date: date,
          );
        } else {
          despesa = Despesa(
            value: value,
            idCategory: category,
            idUser: widget.userId,
            name: name,
            date: date,
          );
        }

        if (widget.despesaParaEditar == null) {
          await DatabaseHelper.instance.insertDespesa(despesa);
        } else {
          await DatabaseHelper.instance.updateDespesa(despesa);
        }

        widget.onAddDespesa(despesa);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid category ID')),
        );
      }
    } else {
      print('Invalid input');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.despesaParaEditar != null ? "Editar Despesa" : "Adicionar Despesa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nome da Despesa",
              ),
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: "Valor",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: "Id Categoria",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Data (AAAA-MM-DD)",
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveDespesa,
              child: Text(widget.despesaParaEditar != null ? "Salvar Alterações" : "Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}