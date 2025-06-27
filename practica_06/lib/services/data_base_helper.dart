// lib/services/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaccion.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'finanzas_personales.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transacciones(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT NOT NULL,
        monto REAL NOT NULL,
        descripcion TEXT NOT NULL,
        categoria TEXT NOT NULL,
        fecha TEXT NOT NULL
      )
    ''');
  }

  // Insertar una nueva transacción
  Future<int> insertTransaccion(Transaccion transaccion) async {
    Database db = await database;
    return await db.insert('transacciones', transaccion.toMap());
  }

  // Obtener todas las transacciones
  Future<List<Transaccion>> getTransacciones() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transacciones',
      orderBy: 'fecha DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaccion.fromMap(maps[i]);
    });
  }

  // Actualizar una transacción
  Future<int> updateTransaccion(Transaccion transaccion) async {
    Database db = await database;
    return await db.update(
      'transacciones',
      transaccion.toMap(),
      where: 'id = ?',
      whereArgs: [transaccion.id],
    );
  }

  // Eliminar una transacción
  Future<int> deleteTransaccion(int id) async {
    Database db = await database;
    return await db.delete('transacciones', where: 'id = ?', whereArgs: [id]);
  }

  // Obtener transacciones por tipo (ingreso/gasto)
  Future<List<Transaccion>> getTransaccionesPorTipo(String tipo) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transacciones',
      where: 'tipo = ?',
      whereArgs: [tipo],
      orderBy: 'fecha DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaccion.fromMap(maps[i]);
    });
  }

  // Obtener transacciones por rango de fechas
  Future<List<Transaccion>> getTransaccionesPorRangoFechas(
    DateTime start,
    DateTime end,
  ) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transacciones',
      where: 'fecha BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'fecha DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaccion.fromMap(maps[i]);
    });
  }
}
