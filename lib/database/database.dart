import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._();
  AppDatabase._();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB("clientes.db");
    return _db!;
  }

  Future<Database> _initDB(String file) async {
    final path = join(await getDatabasesPath(), file);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future _createTables(Database db, int version) async {
    await db.execute("""
      CREATE TABLE clientes (
        idCliente INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL
      );
    """);

    await db.execute("""
      CREATE TABLE parcelas (
        idParcela INTEGER PRIMARY KEY AUTOINCREMENT,
        idCliente INTEGER NOT NULL,
        valor REAL NOT NULL,
        vencimento TEXT NOT NULL,
        isPaid INTEGER NOT NULL,
        FOREIGN KEY (idCliente) REFERENCES clientes(idCliente) ON DELETE CASCADE
      );
    """);

    await db.execute("""
      CREATE TABLE etapas (
        idEtapa INTEGER PRIMARY KEY AUTOINCREMENT,
        idParcela INTEGER NOT NULL,
        nome TEXT NOT NULL,
        mensagem TEXT NOT NULL,
        dataAgendada TEXT NOT NULL,
        concluida INTEGER NOT NULL,
        FOREIGN KEY (idParcela) REFERENCES parcelas(idParcela) ON DELETE CASCADE
      );
    """);
  }
}
