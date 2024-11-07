import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Despesa.dart';
import '../Receita.dart';
import '../User.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('finmanage_v2.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    print('Creating tables...');
    try {
      const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      const textType = 'TEXT NOT NULL';
      const realType = 'REAL NOT NULL';
      const intType = 'INTEGER NOT NULL';

      await db.execute('''
      CREATE TABLE categorias (
        id INTEGER PRIMARY KEY,
        name TEXT,
        icon TEXT,
        color TEXT
      )
    ''');
      await db.execute('''
    CREATE TABLE receitas (
      id $idType,
      value $realType,
      name $textType,
      idCategory $intType,
      idUser $intType,
      date $textType
    )
    ''');

      await db.execute('''
    CREATE TABLE despesas (
      id $idType,
      value $realType,
      name $textType,
      idCategory $intType,
      idUser $intType,
      date $textType
    )
    ''');
      await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        password TEXT
      )
    ''');
      await _insertDefaultCategories(db);
      print('Tables created successfully');
    } catch (e) {
      print('Error creating tables: $e');
    }
  }

  Future<void> _insertDefaultCategories(Database db) async {
    final categories = [
      { "id": 1, "name": "Alimentação", "icon": "Icons.fastfood", "color": "Colors.orange" },
      { "id": 2, "name": "Transporte", "icon": "Icons.directions_car", "color": "Colors.blue" },
      { "id": 3, "name": "Moradia", "icon": "Icons.home", "color": "Colors.teal" },
      { "id": 4, "name": "Saúde", "icon": "Icons.local_hospital", "color": "Colors.red" },
      { "id": 5, "name": "Educação", "icon": "Icons.school", "color": "Colors.green" },
      { "id": 6, "name": "Lazer", "icon": "Icons.sports_esports", "color": "Colors.purple" },
      { "id": 7, "name": "Compras", "icon": "Icons.shopping_cart", "color": "Colors.pink" },
      { "id": 8, "name": "Contas e Serviços", "icon": "Icons.receipt", "color": "Colors.brown" },
      { "id": 9, "name": "Investimentos", "icon": "Icons.trending_up", "color": "Colors.indigo" },
      { "id": 10, "name": "Viagens", "icon": "Icons.flight", "color": "Colors.cyan" },
      { "id": 11, "name": "Família", "icon": "Icons.family_restroom", "color": "Colors.deepOrange" },
      { "id": 12, "name": "Caridade", "icon": "Icons.volunteer_activism", "color": "Colors.deepPurple" },
      { "id": 13, "name": "Impostos", "icon": "Icons.account_balance", "color": "Colors.grey" },
      { "id": 14, "name": "Renda", "icon": "Icons.attach_money", "color": "Colors.greenAccent" },
      { "id": 15, "name": "Outros", "icon": "Icons.more_horiz", "color": "Colors.blueGrey" }
    ];

    for (var category in categories) {
      await db.insert('categorias', category);
    }
  }

  Future<User?> getUser(String email, String password) async {
    final db = await database;
    var res = await db.query("User", where: "email = ? AND password = ?", whereArgs: [email, password]);
    if (res.isNotEmpty) {
      return User.fromMap(res.first);
    }
    return null;
  }

  Future<int> addUser(User user) async {
    final db = await instance.database;
    return await db.insert('user', user.toMap());
  }

  Future<List<Despesa>> getDespesas(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'despesas',
      where: 'idUser = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Despesa(
        id: maps[i]['id'],
        value: maps[i]['value'],
        name: maps[i]['name'],
        idCategory: maps[i]['idCategory'],
        idUser: maps[i]['idUser'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<List<Receita>> getReceitas(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'receitas',
      where: 'idUser = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Receita(
        id: maps[i]['id'],
        value: maps[i]['value'],
        name: maps[i]['name'],
        idCategory: maps[i]['idCategory'],
        idUser: maps[i]['idUser'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<void> insertDespesa(Despesa despesa) async {
    final db = await instance.database;
    await db.insert('despesas', despesa.toMap());
  }

  Future<void> deleteDespesa(int id) async {
    final db = await instance.database;
    await db.delete('despesas', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertReceita(Receita receita) async {
    final db = await instance.database;
    await db.insert('receitas', receita.toMap());
  }

  Future<void> deleteReceita(int id) async {
    final db = await instance.database;
    await db.delete('receitas', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateDespesa(Despesa despesa) async {
    final db = await instance.database;
    await db.update(
      'despesas',
      despesa.toMap(),
      where: 'id = ?',
      whereArgs: [despesa.id],
    );
  }

  Future<void> updateReceita(Receita receita) async {
    final db = await instance.database;
    await db.update(
      'receitas',
      receita.toMap(),
      where: 'id = ?',
      whereArgs: [receita.id],
    );
  }

}