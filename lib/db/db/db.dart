import 'dart:async';
import 'dart:io';
import 'package:kelimeezberleme/db/model/lists.dart';
import 'package:kelimeezberleme/db/model/words.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  static Database ? _dataBase;

  Future<Database> get database async => await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'kelimeezberleme.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRİMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
     CREATE TABLE IF NOT EXISTS $tableNameLists (
     ${listsTableFields.id} $idType,
     ${listsTableFields.name} $textType,
     )
     ''');

    await db.execute('''
     CREATE TABLE IF NOT EXISTS $tableNameWords (
     ${wordTableFields.id} $idType,
     ${wordTableFields.list_id} $integerType,
     ${wordTableFields.word_eng} $textType,
     ${wordTableFields.word_tr} $textType,
     ${wordTableFields.status} $boolType,
     FOREIGN KEY (${wordTableFields.list_id}) REFERENCES  $tableNameLists(${listsTableFields.id}))
     ''');
  }

  // liste oluşturma metodu
  Future<Lists> insertList(Lists lists) async {
    final db = await instance
        .database; // veritabanı oluşmuşsa bağlan oluşmamışsa oluştur
    final id = await db.insert(tableNameLists, lists.toJson());

    return lists.copy(id: id);
  }

  // listeye kelime ekleme metodu
  Future<Word> insertWord(Word word) async {
    final db = await instance.database;
    final id = await db.insert(tableNameWords, word.toJson());

    return word.copy(id: id);
  }

  // listeye göre kelime listesini getirme
  Future<List<Word>> readWordByList(int? listID) async {
    final db = await instance.database;
    final orderBy = '${wordTableFields.id} ASC';
    final result = await db.query(tableNameWords,
        orderBy: orderBy,
        where: '${wordTableFields.list_id} = ? ',
        whereArgs: [listID]);

    return result.map((json) => Word.fromJson(json)).toList();
  }

  // tim listeleri getir
  Future<List<Lists>> readListsAll() async {
    final db = await instance.database;
    final orderBy = '${listsTableFields.id} ASC';
    final result = await db.query(tableNameLists, orderBy: orderBy);

    return result.map((json) => Lists.fromJSon(json)).toList();
  }

  //kelime güncelleme
  Future<int> updateWord(Word word) async {
    final db = await instance.database;
    return db.update(tableNameWords, word.toJson(),
        where: '${wordTableFields.id} = ? ', whereArgs: [word.id]);
  }

  //Liste güncelleme
  Future<int> updateList(Lists lists) async {
    final db = await instance.database;
    return db.update(tableNameLists, lists.toJson(),
        where: '${listsTableFields.id} = ? ', whereArgs: [lists.id]);
  }

  //kelime sil
  Future<int> deleteWord(int id) async {
    final db = await instance.database;
    return db.delete(tableNameWords,
        where: '${wordTableFields.id} = ?', whereArgs: [id]);
  }

  //listeyi ve liste altındaki kelimeleri sil
  Future<int> deleteListsAndwordByList(int id) async {
    final db = await instance.database;
    int result = await db.delete(tableNameLists,
        where: '${listsTableFields.id} = ?', whereArgs: [id]);
    if (result == 1) {
      await db.delete(tableNameWords,
          where: '${wordTableFields.list_id} = ?', whereArgs: [id]);
    }
    return result;
  }

  // Bağlantıyı kapatma
  Future close() async {
    final db = await instance.database;
    db.close();
  }

}
