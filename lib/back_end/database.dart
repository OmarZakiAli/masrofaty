
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'transaction_model.dart' as tr;

class DBProvider {
  
  
  DBProvider._();
  static final DBProvider db = DBProvider._();

 static Database _database;




  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }




initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Transactions.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("""
         CREATE TABLE Trans ("""
          "time Text PRIMARY KEY,"
          "item TEXT,"
          "price DOUBLE"
          ")");
    });
  }


insertTransaction(tr.Transaction transaction) async {
    final db = await database;
    var res = await db.insert("Trans",transaction.toMap() );
    return res;
  }


getTransaction(String time) async {
    final db = await database;
    var res =await  db.query("Trans", where: "time = ?", whereArgs: [time]);
    return res.isNotEmpty ? tr.Transaction.fromMap(res.first) : Null ;
  }



 getAllTransactions() async {
    final db = await database;
    var res = await db.query("Trans");
    List<tr.Transaction> list =
        res.isNotEmpty ? res.map((c) => tr.Transaction.fromMap(c)).toList() : [];
    return list;
  }

  deleteTransaction(String time) async {
    final db = await database;
    db.delete("Trans", where: "time = ?", whereArgs: [time]);
  }


}

