import 'package:flutter/material.dart';
import 'package:finmanage_mobile/Receita.dart';

class AddReceitaScreen extends StatefulWidget {
  final Function(Receita) onAddReceita;
  final int nextId;
  final Receita? receitaParaEditar; // Parâmetro opcional para edição

  const AddReceitaScreen({
    super.key,
    required this.onAddReceita,
    required this.nextId,
    this.receitaParaEditar, // Parâmetro opcional
  });

  @override
  _AddReceitaScreenState createState() => _AddReceitaScreenState();
}

class _AddReceitaScreenState extends State<AddReceitaScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.receitaParaEditar != null) {
      _nameController.text = widget.receitaParaEditar!.name;
      _valueController.text = widget.receitaParaEditar!.value.toString();
      _categoryController.text = widget.receitaParaEditar!.idCategory.toString();
      _dateController.text = widget.receitaParaEditar!.date.toIso8601String().split('T')[0];
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

  void _saveReceita() {
    final String name = _nameController.text;
    final double? value = double.tryParse(_valueController.text);
    final int category = int.tryParse(_categoryController.text) ?? 1;
    const int userId = 1;
    final DateTime? date = DateTime.tryParse(_dateController.text);

    if (name.isNotEmpty && value != null && date != null) {
      final receita = Receita(
        id: widget.receitaParaEditar?.id ?? widget.nextId, // Usa o ID existente se estiver editando
        value: value,
        idCategory: category,
        idUser: userId,
        name: name,
        date: date,
      );

      widget.onAddReceita(receita); // Adiciona ou edita a receita
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receitaParaEditar != null ? "Editar Receita" : "Adicionar Receita"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nome da Receita",
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
              onPressed: _saveReceita,
              child: Text(widget.receitaParaEditar != null ? "Salvar Alterações" : "Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
