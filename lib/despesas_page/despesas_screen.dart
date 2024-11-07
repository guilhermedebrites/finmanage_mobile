import 'package:finmanage_mobile/despesas_page/items/add_despesa_screen.dart';
import 'package:finmanage_mobile/despesas_page/items/header_secondary_pages.dart';
import 'package:finmanage_mobile/home_page/itens/box_icon.dart';
import 'package:flutter/material.dart';
import '../Category.dart';
import '../Despesa.dart';
import '../repository/database_helper.dart';

class DespesasScreen extends StatefulWidget {
  final int userId;
  final List<Category> categories;

  const DespesasScreen({super.key, required this.userId, required this.categories});

  @override
  _DespesasScreenState createState() => _DespesasScreenState();
}

class _DespesasScreenState extends State<DespesasScreen> {
  int _nextId = 1;
  List<Despesa> _despesas = [];

  @override
  void initState() {
    super.initState();
    _loadDespesas();
  }

  Future<void> _loadDespesas() async {
    final despesas = await DatabaseHelper.instance.getDespesas(widget.userId);
    setState(() {
      _despesas = despesas;
    });
  }

  void _addDespesa(Despesa novaDespesa) {
    setState(() {
      _despesas.add(novaDespesa);
      _nextId++;
    });
  }

  void _deleteDespesa(int id) async {
    await DatabaseHelper.instance.deleteDespesa(id);
    setState(() {
      _despesas.removeWhere((despesa) => despesa.id == id);
    });
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Deleção'),
          content: Text('Você tem certeza que deseja deletar esta despesa?'),
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
                _deleteDespesa(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editDespesa(Despesa despesaEditada) {
    setState(() {
      final index = _despesas.indexWhere((despesa) => despesa.id == despesaEditada.id);
      if (index != -1) {
        _despesas[index] = despesaEditada;
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
                mainText: 'Despesas lançadas',
                secondaryText: 'transações',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _despesas.length,
              itemBuilder: (context, index) {
                final despesa = _despesas[index];
                final category = widget.categories
                    .firstWhere((category) =>
                widget.categories.indexOf(category) ==
                    despesa.idCategory - 1);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  child: ListTile(
                    leading: BoxIcon(
                      icon: category.icon,
                      colorIcon: category.color,
                      colorBackground: category.color.withOpacity(0.3),
                    ),
                    title: Text(despesa.name),
                    subtitle: Text('R\$ ${despesa.value.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${despesa.date.day.toString().padLeft(2, '0')}/${despesa.date.month.toString().padLeft(2, '0')}/${despesa.date.year}',
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddDespesaScreen(
                                  onAddDespesa: _editDespesa,
                                  despesaParaEditar: despesa,
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
                            _confirmDelete(context, despesa.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );


              },
            ),
          ),
          const SizedBox(height: 50),
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
                builder: (context) => AddDespesaScreen(
                  onAddDespesa: _addDespesa,
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