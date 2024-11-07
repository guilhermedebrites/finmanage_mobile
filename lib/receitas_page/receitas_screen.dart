import 'package:finmanage_mobile/Receita.dart';
import 'package:finmanage_mobile/despesas_page/items/header_secondary_pages.dart';
import 'package:finmanage_mobile/home_page/itens/box_icon.dart';
import 'package:flutter/material.dart';
import '../Category.dart';
import 'package:finmanage_mobile/receitas_page/add_receita_screen.dart';
import '../repository/database_helper.dart';

class ReceitasScreen extends StatefulWidget {
  final int userId;
  final List<Category> categories;

  const ReceitasScreen({super.key, required this.userId, required this.categories});

  @override
  _ReceitasScreenState createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  int _nextId = 1;
  List<Receita> _receitas = [];

  @override
  void initState() {
    super.initState();
    _loadReceitas();
  }

  Future<void> _loadReceitas() async {
    final receitas = await DatabaseHelper.instance.getReceitas(widget.userId);
    setState(() {
      _receitas = receitas;
    });
  }

  void _addReceita(Receita novaReceita) {
    setState(() {
      _receitas.add(novaReceita);
      _nextId++;
    });
  }

  void _deleteReceita(int id) async {
    await DatabaseHelper.instance.deleteReceita(id);
    setState(() {
      _receitas.removeWhere((receita) => receita.id == id);
    });
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Deleção'),
          content: Text('Você tem certeza que deseja deletar esta receita?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Deletar'),
              onPressed: () {
                _deleteReceita(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editReceita(Receita receitaEditada) {
    setState(() {
      final index = _receitas.indexWhere((receita) => receita.id == receitaEditada.id);
      if (index != -1) {
        _receitas[index] = receitaEditada;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7D7D7),
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: const HeaderSecondaryPages(
                mainText: 'Receitas lançadas',
                secondaryText: 'transações',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _receitas.length,
              itemBuilder: (context, index) {
                final receita = _receitas[index];
                final category = widget.categories
                    .firstWhere((category) =>
                widget.categories.indexOf(category) ==
                    receita.idCategory - 1);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  child: ListTile(
                    leading: BoxIcon(
                      icon: category.icon,
                      colorIcon: category.color,
                      colorBackground: category.color.withOpacity(0.3),
                    ),
                    title: Text(receita.name),
                    subtitle: Text('R\$ ${receita.value.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${receita.date.day.toString().padLeft(2, '0')}/${receita.date.month.toString().padLeft(2, '0')}/${receita.date.year}',
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddReceitaScreen(
                                  onAddReceita: _editReceita,
                                  receitaParaEditar: receita,
                                  nextId: _nextId,
                                  userId: widget.userId,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDelete(context, receita.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );

              },
            ),
          ),
          const SizedBox(height: 66),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddReceitaScreen(
                  onAddReceita: _addReceita,
                  nextId: _nextId,
                  userId: widget.userId,
                ),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.green),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}