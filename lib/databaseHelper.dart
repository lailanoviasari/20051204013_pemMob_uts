import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        ID INTEGER PRIMARY KEY NOT NULL,
        title TEXT,
        synopsis TEXT,
        year TEXT,
        cast TEXT,
        genre TEXT,
        status TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// ID: the id of a item
// title : judul film atau drama yang ingin ditonton, 
// synopsis : deskripsi singkat tentang film atau drama, 
// year : tahun rilis, 
// cast : pemeran film atau drama, 
// genre : jenis film, seperti action, komedi, atau romantis,  
// status: sudah di tonton atau belum,
// created_at: waktu membuat wishlist, otomatis terisi di database.

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'wishlist.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(int ID, String title, String synopsis, int year, String cast, String genre, String status) async {
    final db = await SQLHelper.db();

    final data = {'ID': ID, 'title': title, 'synopsis': synopsis, 'year': year, 'cast': cast, 'genre': genre, 'status': status};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  // skarang tdk digunakan, untuk cadangan jika perlu
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String synopsis, int year, String cast, String genre, String status) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'synopsis': synopsis, 
      'year': year, 
      'cast': cast, 
      'genre': genre, 
      'status': status,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}