import 'package:finmanage_mobile/Despesa.dart';
import 'package:flutter/material.dart';
import 'package:finmanage_mobile/Receita.dart';

class AddDespesaScreen extends StatefulWidget {
  final Function(Despesa) onAddDespesa;
  final int nextId;

  const AddDespesaScreen(
      {super.key, required this.onAddDespesa, required this.nextId});

  @override
  _AddDespesaScreenState createState() => _AddDespesaScreenState();
}

class _AddDespesaScreenState extends State<AddDespesaScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _saveDespesa() {
    final String name = _nameController.text;
    final double? value = double.tryParse(_valueController.text);
    final int category = int.tryParse(_categoryController.text) ?? 1;
    const int userId = 1;
    final DateTime? date = DateTime.tryParse(_dateController.text);

    if (name.isNotEmpty && value != null && date != null) {
      final newDespesa = Despesa(
        id: widget.nextId,
        value: value,
        idCategory: category,
        idUser: userId,
        name: name,
        date: date,
      );

      widget
          .onAddDespesa(newDespesa);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Receita"),
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
              onPressed:
              _saveDespesa,
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}