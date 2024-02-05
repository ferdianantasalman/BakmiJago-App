import 'dart:developer';

import 'package:bakmi_jago_app/models/cart_model.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._privateConstructor();
  static final CartDatabaseHelper instance =
      CartDatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, sqfliteDatabaseName);
    log('Database initiated');
    return await openDatabase(path,
        version: sqfliteDatabaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable (
        $cartColumnId INTEGER PRIMARY KEY,        
        $cartColumnName TEXT NOT NULL,
        $cartColumnQuantity INTEGER NOT NULL,
        $cartColumnPrice REAL NOT NULL,
        $cartColumnImage TEXT NOT NULL,
        $cartColumSubtotalPerItem REAL NOT NULL
      )
    ''');
  }

  Future<int> insert(CartModel cartModel) async {
    final db = await database;
    return await db.insert(cartTable, cartModel.toMap());
  }

  Future<List<CartModel>> query() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(cartTable);
    return List.generate(maps.length, (i) {
      return CartModel(
          id: maps[i][cartColumnId],
          name: maps[i][cartColumnName],
          quantity: maps[i][cartColumnQuantity],
          price: maps[i][cartColumnPrice].round(),
          image: maps[i][cartColumnImage],
          subtotalPerItem: maps[i][cartColumSubtotalPerItem].round());
    });
  }

  Future<int> update(CartModel cartModel) async {
    final db = await database;
    return await db.update(cartTable, cartModel.toMap(),
        where: '$cartColumnId = ?', whereArgs: [cartModel.id]);
  }

  Future<double> getItemSubtotal() async {
    final db = await database;
    final data = await db
        .rawQuery("SELECT SUM($cartColumSubtotalPerItem) FROM $cartTable");
    final subtotal = data[0]["SUM($cartColumSubtotalPerItem)"].toString();
    return double.parse(subtotal);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db
        .delete(cartTable, where: '$cartColumnId = ?', whereArgs: [id]);
  }

  Future deleteAllData() async {
    final db = await instance.database;

    db.execute("delete from $cartTable");
    db.execute("vacuum");
  }
}
