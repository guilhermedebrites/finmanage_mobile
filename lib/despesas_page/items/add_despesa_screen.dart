import 'package:finmanage_mobile/Despesa.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../repository/database_helper.dart';
import '../../Category.dart';

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
  final TextEditingController _dateController = TextEditingController();
  List<Category> _categories = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();

    if (widget.despesaParaEditar != null) {
      _nameController.text = widget.despesaParaEditar!.name;
      _valueController.text = widget.despesaParaEditar!.value.toString();
      _dateController.text = widget.despesaParaEditar!.date.toIso8601String().split('T')[0];
    }
  }

  Future<void> _loadCategories() async {
    final categories = await DatabaseHelper.instance.getCategorias();
    setState(() {
      _categories = categories;
      if (widget.despesaParaEditar != null) {
        _selectedCategory = _categories.firstWhere((category) => category.id == widget.despesaParaEditar!.idCategory);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _saveDespesa() async {
    final String name = _nameController.text;
    final double? value = double.tryParse(_valueController.text);
    final DateTime? date = DateTime.tryParse(_dateController.text);

    if (name.isNotEmpty && value != null && date != null && _selectedCategory != null) {
      Despesa despesa;
      if (widget.despesaParaEditar != null) {
        despesa = Despesa(
          id: widget.despesaParaEditar!.id,
          value: value,
          idCategory: _selectedCategory!.id,
          idUser: widget.userId,
          name: name,
          date: date,
        );
      } else {
        despesa = Despesa(
          value: value,
          idCategory: _selectedCategory!.id,
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
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toIso8601String().split('T')[0];
      });
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
            DropdownButton<Category>(
              value: _selectedCategory,
              hint: const Text("Selecione uma Categoria"),
              onChanged: (Category? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              items: _categories.map<DropdownMenuItem<Category>>((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Data",
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
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