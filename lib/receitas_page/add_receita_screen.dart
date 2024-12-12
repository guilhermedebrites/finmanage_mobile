import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:finmanage_mobile/Receita.dart';
import '../repository/database_helper.dart';
import '../Category.dart';

class AddReceitaScreen extends StatefulWidget {
  final Function(Receita) onAddReceita;
  final int nextId;
  final String userId;
  final Receita? receitaParaEditar;

  const AddReceitaScreen({
    super.key,
    required this.onAddReceita,
    required this.nextId,
    required this.userId,
    this.receitaParaEditar,
  });

  @override
  _AddReceitaScreenState createState() => _AddReceitaScreenState();
}

class _AddReceitaScreenState extends State<AddReceitaScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<Category> _categories = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();

    if (widget.receitaParaEditar != null) {
      _nameController.text = widget.receitaParaEditar!.name;
      _valueController.text = widget.receitaParaEditar!.value.toString();
      _dateController.text = widget.receitaParaEditar!.date.toIso8601String().split('T')[0];
    }
  }

  Future<void> _loadCategories() async {
    final categories = await DatabaseHelper.instance.getCategorias();
    setState(() {
      _categories = categories;
      if (widget.receitaParaEditar != null) {
        _selectedCategory = _categories.firstWhere((category) => category.id == widget.receitaParaEditar!.idCategory);
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

  Future<void> _saveReceita() async {
    final String name = _nameController.text;
    final double? value = double.tryParse(_valueController.text);
    final DateTime? date = DateTime.tryParse(_dateController.text);

    if (name.isNotEmpty && value != null && date != null && _selectedCategory != null) {
      Receita receita;
      if (widget.receitaParaEditar != null) {
        receita = Receita(
          id: widget.receitaParaEditar!.id,
          value: value,
          idCategory: _selectedCategory!.id,
          idUser: widget.userId,
          name: name,
          date: date,
        );
      } else {
        receita = Receita(
          value: value,
          idCategory: _selectedCategory!.id,
          idUser: widget.userId,
          name: name,
          date: date,
        );
      }

      if (widget.receitaParaEditar == null) {
        await DatabaseHelper.instance.insertReceita(receita);
      } else {
        await DatabaseHelper.instance.updateReceita(receita);
      }

      widget.onAddReceita(receita);
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
              onPressed: _saveReceita,
              child: Text(widget.receitaParaEditar != null ? "Salvar Alterações" : "Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}